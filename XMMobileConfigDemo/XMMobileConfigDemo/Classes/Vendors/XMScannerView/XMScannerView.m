//
//  XMScannerView.m
//  XMScanner
//
//  Created by chi on 15-3-30.
//  Copyright (c) 2015年 chi. All rights reserved.
//

#import "XMScannerView.h"


@interface XMScannerView()

/**
 *  扫描相机控制实例
 */
@property (nonatomic, strong) MTBBarcodeScanner *scanner;


/**
 *  支持扫描的类型数组
 */
@property (nonatomic, copy) NSArray *metaDataObjectTypes;

/**
 *  扫描相机占位视图
 */
@property (nonatomic, weak) UIView *previewView;

/**
 *  背景遮罩视图
 */
@property (nonatomic, weak) UIImageView *maskImageView;

/**
 *  扫描区域占位视图
 */
@property (nonatomic, weak) UIView *scanAreaPlaceholderView;

/**
 *  扫描区域占位视图宽约束
 */
@property (nonatomic, weak) NSLayoutConstraint *scanAreaPlaceholderViewWidthCons;

/**
 *  扫描区域占位视图高约束
 */
@property (nonatomic, weak) NSLayoutConstraint *scanAreaPlaceholderViewHeightCons;

/**
 *  扫描区域占位视图距离上边约束
 */
@property (nonatomic, weak) NSLayoutConstraint *scanAreaPlaceholderViewTopMarginCons;

/**
 *  扫描横线
 */
@property (nonatomic, weak) UIImageView *scanLineImageView;


/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *timer;


/**
 *  扫描实时信息
 */
@property (strong, nonatomic) NSMutableDictionary *overlayViews;


@end

@implementation XMScannerView

- (instancetype)initWithMetadataObjectTypes:(NSArray *)metaDataObjectTypes
{
    if (self = [super init]) {
        _metaDataObjectTypes = metaDataObjectTypes;

        // 初始化
        [self commonInit];
    }
    
    return self;
}


/**
 *  开始扫描
 *
 *  @param resultBlock 扫描回调
 */
- (void)startScanningWithResultBlock:(void (^)(NSArray *codes))resultBlock
{
    
    if ([MTBBarcodeScanner cameraIsPresent]) {
        self.scanLineImageView.hidden = NO;
        [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
            
            if (self.drawOverlaysOnCodes) {
                [self drawOverlaysOnCodes:codes];
            }
            
            if (resultBlock) {
                resultBlock(codes);
            }
            
            
        }];
    }
    
}

/**
 *  停止扫描
 */
- (void)stopScanning
{
    [self.timer invalidate];
    self.scanLineImageView.hidden = YES;
    [self removeDrawOverlaysOnCodes];
    [self.scanner stopScanning];
    
}




/**
 *  初始化
 */
- (void)commonInit
{
    self.timerInterval = 0.0f;
    self.scanAreaTopMargin = -100.0f;
    self.drawOverlaysOnCodes = YES;
    
    // 扫描相机占位视图
    UIView *previewView = [[UIView alloc]init];
    self.previewView = previewView;
    [self addSubview:previewView];
    [self xmLayoutSubView:previewView fillInSuperView:self];
    if (self.metaDataObjectTypes.count > 0) {
        self.scanner = [[MTBBarcodeScanner alloc]initWithMetadataObjectTypes:self.metaDataObjectTypes previewView:previewView];
    }
    else {
        self.scanner = [[MTBBarcodeScanner alloc]initWithPreviewView:previewView];
    }
    
    
    // 中间透明，外边半透明图片视图
    UIImageView *maskImageView = [[UIImageView alloc]init];
    self.maskImageView = maskImageView;
    [self addSubview:maskImageView];
    [self xmLayoutSubView:maskImageView fillInSuperView:self];
    
    
    // 扫描区域占位视图
    UIView *scanAreaPlaceholderView = [[UIImageView alloc]init];
    [self addSubview:scanAreaPlaceholderView];
    self.scanAreaPlaceholderView = scanAreaPlaceholderView;
    scanAreaPlaceholderView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    // 横向居中
    NSLayoutConstraint *scanAreaPlaceholderViewCenterX = [NSLayoutConstraint constraintWithItem:scanAreaPlaceholderView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0];
    [self addConstraint:scanAreaPlaceholderViewCenterX];
    
    // 距离上边距
    NSLayoutConstraint *scanAreaPlaceholderViewTopMargin = [NSLayoutConstraint constraintWithItem:scanAreaPlaceholderView attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTopMargin multiplier:1.0f constant:0.0];
    [self addConstraint:scanAreaPlaceholderViewTopMargin];
    self.scanAreaPlaceholderViewTopMarginCons = scanAreaPlaceholderViewTopMargin;
    
    // 设置大小
    CGFloat scanAreaPlaceholderViewW = 0.0f;
    CGFloat scanAreaPlaceholderViewH = 0.0f;
    
    if (self.scanAreaSize.width > 0) {
        scanAreaPlaceholderViewW = self.scanAreaSize.width;
    }
    
    if (self.scanAreaSize.height > 0) {
        scanAreaPlaceholderViewH = self.scanAreaSize.height;
    }
    
    
    NSLayoutConstraint *scanAreaPlaceholderViewWidthCons = [NSLayoutConstraint constraintWithItem:scanAreaPlaceholderView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:scanAreaPlaceholderViewW];
    [scanAreaPlaceholderView addConstraint:scanAreaPlaceholderViewWidthCons];
    self.scanAreaPlaceholderViewWidthCons = scanAreaPlaceholderViewWidthCons;
    
    NSLayoutConstraint *scanAreaPlaceholderViewHeightCons = [NSLayoutConstraint constraintWithItem:scanAreaPlaceholderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:scanAreaPlaceholderViewH];
    [scanAreaPlaceholderView addConstraint:scanAreaPlaceholderViewHeightCons];
    self.scanAreaPlaceholderViewHeightCons = scanAreaPlaceholderViewHeightCons;
    
    
    // 白边框占位视图
    UIView *scanAreaBorderView = [[UIView alloc]init];
    [scanAreaPlaceholderView addSubview:scanAreaBorderView];
    [self xmLayoutSubView:scanAreaBorderView fillInSuperView:scanAreaPlaceholderView];
    scanAreaBorderView.layer.borderColor = [UIColor whiteColor].CGColor;
    scanAreaBorderView.layer.borderWidth = 1.0f;
    
    // 创建扫描区域4边框视图
    [self setupPicViews];
    
    
    
}



/**
 *  创建中间透明，旁边半透明UIImage
 *
 *  @param imageSize  图片大小
 *  @param centerRect 透明区域
 *
 *  @return 生成的图片
 */
- (UIImage*)createBackgroundImageWithImageSize:(CGSize)imageSize centerRect:(CGRect)centerRect
{
    
    if (imageSize.width <= 0.0 || imageSize.height <= 0.0 || CGSizeEqualToSize(imageSize, centerRect.size)) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0.0,0,0,0.5);
    CGRect drawRect =CGRectMake(0, 0, imageSize.width,imageSize.height);
    
    CGContextFillRect(ctx, drawRect);   //draw the transparent layer
    
    CGContextClearRect(ctx, centerRect);  //clear the center rect  of the layer
    
    UIImage* returnimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return returnimage;
}


- (UIImage*)loadImageFromBarcodeScannerBundleWithName:(NSString*)imageName
{
    NSBundle *imageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"BarcodeScanner" ofType:@"bundle"]];
    
    if ([UIScreen mainScreen].scale > 2) {
        imageName = [NSString stringWithFormat:@"%@@%dx", imageName, (int)[UIScreen mainScreen].scale];
    }
    else {
        imageName = [NSString stringWithFormat:@"%@@2x", imageName];
    }
    
    NSString *imagePath = [imageBundle pathForResource:imageName ofType:@"png"];
    
    UIImage *retImage = [UIImage imageWithContentsOfFile:imagePath];
    
    
    return retImage;
    
}


/**
 *  创建四角图片视图
 */
- (void)setupPicViews
{
    self.scanAreaPlaceholderView.backgroundColor = [UIColor clearColor];

#pragma mark - 四个角
    // 左上
    UIImageView *ScanQR1View = [self createScanQRImageView];
    ScanQR1View.image = [self loadImageFromBarcodeScannerBundleWithName:@"ScanQR1"];
    
    NSDictionary *metrics = @{@"ScanQRViewHW":@(16.0f), @"margin":@(-0.5f)};
    NSDictionary *views = @{@"ScanQR1View":ScanQR1View};
    
    NSArray *ScanQR1ConsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[ScanQR1View(ScanQRViewHW)]" options:0 metrics:metrics views:views];
    [self.scanAreaPlaceholderView addConstraints:ScanQR1ConsH];
    
    NSArray *ScanQR1ConsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[ScanQR1View(ScanQRViewHW)]" options:0 metrics:metrics views:views];
    [self.scanAreaPlaceholderView addConstraints:ScanQR1ConsV];
    
    // 右上
    UIImageView *ScanQR2View = [self createScanQRImageView];
    ScanQR2View.image = [self loadImageFromBarcodeScannerBundleWithName:@"ScanQR2"];
    
    views = @{@"ScanQR2View":ScanQR2View};
    
    NSArray *ScanQR2ConsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[ScanQR2View(ScanQRViewHW)]-margin-|" options:0 metrics:metrics views:views];
    [self.scanAreaPlaceholderView addConstraints:ScanQR2ConsH];
    
    NSArray *ScanQR2ConsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[ScanQR2View(ScanQRViewHW)]" options:0 metrics:metrics views:views];
    [self.scanAreaPlaceholderView addConstraints:ScanQR2ConsV];
    
    // 左下
    UIImageView *ScanQR3View = [self createScanQRImageView];
    ScanQR3View.image = [self loadImageFromBarcodeScannerBundleWithName:@"ScanQR3"];
    
    views = @{@"ScanQR3View":ScanQR3View};
    
    NSArray *ScanQR3ConsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[ScanQR3View(ScanQRViewHW)]" options:0 metrics:metrics views:views];
    [self.scanAreaPlaceholderView addConstraints:ScanQR3ConsH];
    
    NSArray *ScanQR3ConsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[ScanQR3View(ScanQRViewHW)]-margin-|" options:0 metrics:metrics views:views];
    [self.scanAreaPlaceholderView addConstraints:ScanQR3ConsV];
    
    // 右下
    UIImageView *ScanQR4View = [self createScanQRImageView];
    ScanQR4View.image = [self loadImageFromBarcodeScannerBundleWithName:@"ScanQR4"];
    
    views = @{@"ScanQR4View":ScanQR4View};
    
    NSArray *ScanQR4ConsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[ScanQR4View(ScanQRViewHW)]-margin-|" options:0 metrics:metrics views:views];
    [self.scanAreaPlaceholderView addConstraints:ScanQR4ConsH];
    
    NSArray *ScanQR4ConsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[ScanQR4View(ScanQRViewHW)]-margin-|" options:0 metrics:metrics views:views];
    [self.scanAreaPlaceholderView addConstraints:ScanQR4ConsV];
    
    
#pragma mark - 扫描横线
    
    UIImageView *scanLineImageView = [[UIImageView alloc]init];
    self.scanLineImageView = scanLineImageView;
    [self.scanAreaPlaceholderView addSubview:scanLineImageView];
    
    UIImage *lineImage = [self loadImageFromBarcodeScannerBundleWithName:@"ff_QRCodeScanLine"];
    scanLineImageView.image = [lineImage stretchableImageWithLeftCapWidth:0.5 * lineImage.size.width topCapHeight:0.5 * lineImage.size.height];
    scanLineImageView.hidden = YES;
    if (self.timerInterval <= 0.0) {
        self.timerInterval = 0.02;
    }
    
    
}


- (void)setScanAreaTopMargin:(CGFloat)scanAreaTopMargin
{
    _scanAreaTopMargin = scanAreaTopMargin;
    self.scanAreaPlaceholderViewTopMarginCons.constant = scanAreaTopMargin;
}

/**
 *  创建定时器
 */
- (void)setTimerInterval:(CGFloat)timerInterval
{
    _timerInterval = timerInterval;
    
    if (self.timer) {
        [self.timer invalidate];
        
    }
    
    
    if (timerInterval <= 0.0) {
        return;
    }
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(animationScanLine) userInfo:nil repeats:YES];
    
    
    
    
}

/**
 *  计算扫描条变化
 */
- (void)animationScanLine
{
    CGRect frame = self.scanLineImageView.frame;
    CGFloat height = CGRectGetHeight(self.scanAreaPlaceholderView.bounds) - 5.0;
    CGFloat deltaY = 4.0f;
    frame.origin.y += deltaY;
    if (frame.origin.y >= height) {
        frame.origin.y = 0.0f;
    }
    
    self.scanLineImageView.frame = frame;
}



- (UIImageView*)createScanQRImageView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.scanAreaPlaceholderView addSubview:imageView];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    return imageView;
}


#pragma mark - 显示扫描实时提示

- (void)setDrawOverlaysOnCodes:(BOOL)drawOverlaysOnCodes
{
    _drawOverlaysOnCodes = drawOverlaysOnCodes;
    if (drawOverlaysOnCodes == NO) {
        [self removeDrawOverlaysOnCodes];
    }
}

/**
 *  移除
 */
- (void)removeDrawOverlaysOnCodes
{
    // Remove any code overlays no longer on the screen
    for (NSString *code in self.overlayViews.allKeys) {
        [self.overlayViews[code] removeFromSuperview];
        [self.overlayViews removeObjectForKey:code];
    }
}

- (void)drawOverlaysOnCodes:(NSArray *)codes {
    // Get all of the captured code strings
    NSMutableArray *codeStrings = [[NSMutableArray alloc] init];
    for (AVMetadataMachineReadableCodeObject *code in codes) {
        if (code.stringValue) {
            [codeStrings addObject:code.stringValue];
        }
    }
    
    // Remove any code overlays no longer o.n the screen
    for (NSString *code in self.overlayViews.allKeys) {
        if ([codeStrings indexOfObject:code] == NSNotFound) {
            // A code that was on the screen is no longer
            // in the list of captured codes, remove its overlay
            [self.overlayViews[code] removeFromSuperview];
            [self.overlayViews removeObjectForKey:code];
        }
    }
    
    for (AVMetadataMachineReadableCodeObject *code in codes) {
        UIView *view = nil;
        NSString *codeString = code.stringValue;
        
        if (codeString) {
            if (self.overlayViews[codeString]) {
                // The overlay is already on the screen
                view = self.overlayViews[codeString];
                
                // Move it to the new location
                view.frame = code.bounds;
                
            } else {
                // First time seeing this code
                BOOL isValidCode = [self isValidCodeString:codeString];
                
                // Create an overlay
                UIView *overlayView = [self overlayForCodeString:codeString
                                                          bounds:code.bounds
                                                           valid:isValidCode];
                self.overlayViews[codeString] = overlayView;
                
                // Add the overlay to the preview view
                [self.previewView addSubview:overlayView];
                
            }
        }
    }
}

- (BOOL)isValidCodeString:(NSString *)codeString {
    BOOL stringIsValid = ([codeString rangeOfString:@"Valid"].location != NSNotFound);
    return stringIsValid;
}

- (UIView *)overlayForCodeString:(NSString *)codeString bounds:(CGRect)bounds valid:(BOOL)valid {
    
    UIColor *viewColor = valid ? [UIColor greenColor] : [UIColor redColor];
    UIView *view = [[UIView alloc] initWithFrame:bounds];
    //    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    
    // Configure the view
    view.layer.borderWidth = 5.0;
    view.backgroundColor = [viewColor colorWithAlphaComponent:0.75];
    view.layer.borderColor = viewColor.CGColor;
    
    //    // Configure the label
    //    label.font = [UIFont boldSystemFontOfSize:12];
    //    label.text = codeString;
    //    label.textColor = [UIColor blackColor];
    //    label.textAlignment = NSTextAlignmentCenter;
    //    label.numberOfLines = 0;
    //
    //    // Add constraints to label to improve text size?
    //
    //    // Add the label to the view
    //    [view addSubview:label];
    
    return view;
}

- (NSMutableDictionary *)overlayViews {
    if (!_overlayViews) {
        _overlayViews = [[NSMutableDictionary alloc] init];
    }
    return _overlayViews;
}

/**
 *  子视图布局
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算扫描相机LayerFrame
    [self.scanner calculateLayerFrame];
    
    
    
    
    if (CGSizeEqualToSize(self.scanAreaPlaceholderView.frame.size, CGSizeZero)) {
        self.scanAreaPlaceholderViewHeightCons.constant = CGRectGetHeight(self.previewView.frame);
        self.scanAreaPlaceholderViewWidthCons.constant = CGRectGetWidth(self.previewView.frame);
        [super layoutSubviews];
    }
    
    CGFloat scanAreaPlaceholderWidth = CGRectGetWidth(self.scanAreaPlaceholderView.frame);
    CGFloat scanAreaPlaceholderHeight = CGRectGetHeight(self.scanAreaPlaceholderView.frame);
    
    if (self.scanAreaTopMargin <= -100.0f) {
        self.scanAreaPlaceholderViewTopMarginCons.constant = (CGRectGetHeight(self.bounds) - scanAreaPlaceholderHeight) * 0.5f;
        [super layoutSubviews];
    }
    
    
    // 初始化扫描线条位置
    self.scanLineImageView.bounds = CGRectMake(0.0, 0.0, scanAreaPlaceholderWidth, 12.0f);
    self.scanLineImageView.center = CGPointMake(scanAreaPlaceholderWidth * 0.5, 0.0);
    
    
    UIImage *maskImage = [self createBackgroundImageWithImageSize:self.bounds.size centerRect:self.scanAreaPlaceholderView.frame];
    if (maskImage) {
        self.maskImageView.image = maskImage;
        
        if (self.scanAreaSize.width > 0 && self.scanAreaSize.height > 0) {
            CGFloat previewViewHeight = CGRectGetHeight(self.previewView.frame);
            CGFloat previewViewWidth = CGRectGetWidth(self.previewView.frame);
            
            CGFloat scanAreaY = CGRectGetMinY(self.scanAreaPlaceholderView.frame);
            CGFloat scanAreaX = CGRectGetMinX(self.scanAreaPlaceholderView.frame);
            CGFloat scanAreaW = CGRectGetWidth(self.scanAreaPlaceholderView.frame);
            CGFloat scanAreaH = CGRectGetHeight(self.scanAreaPlaceholderView.frame);
            // y的起点/屏幕的高，x的起点/屏幕的宽，扫描的区域的高/屏幕的高，扫描的区域的宽/屏幕的宽）
            CGRect rectOfInterest = CGRectMake((scanAreaY) / previewViewHeight, (scanAreaX) / previewViewWidth, scanAreaH / previewViewHeight, scanAreaW / previewViewWidth);
            
            [self.scanner setCaptureRectOfInterest:rectOfInterest];
        }
        
        
    }
}



/**
 *  设置扫描区域大小
 *
 *  @param scanAreaSize 扫描区域大小
 */
- (void)setScanAreaSize:(CGSize)scanAreaSize
{
    _scanAreaSize = scanAreaSize;
    if (scanAreaSize.width > 0) {
        self.scanAreaPlaceholderViewWidthCons.constant = scanAreaSize.width;
    }
    
    if (scanAreaSize.height > 0) {
        self.scanAreaPlaceholderViewHeightCons.constant = scanAreaSize.height;
    }
}


/**
 *  检查设置有没有相机功能
 */
+ (BOOL)cameraIsPresent
{
    return [MTBBarcodeScanner cameraIsPresent];
}

/**
 *  检查app是否被禁止访问相机
 */
+ (BOOL)scanningIsProhibited
{
    return [MTBBarcodeScanner scanningIsProhibited];
}



#pragma mark - 类工厂方法
+(instancetype)xmScannerViewWithScanAreaSize:(CGSize)scanAreaSize metadataObjectTypes:(NSArray *)metaDataObjectTypes
{
    XMScannerView *scanView = [[self alloc]initWithMetadataObjectTypes:metaDataObjectTypes];
    scanView.scanAreaSize = scanAreaSize;
    
    return scanView;
}



#pragma mark - autolayout



/**
 *  填充父视图Layout
 *
 *  @param subView   子视图
 *  @param superView 父视图
 */
- (void)xmLayoutSubView:(UIView*)subView fillInSuperView:(UIView*)superView
{
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = @{@"subView":subView, @"superView":superView};
    
    // 横向约束
    NSArray *viewConsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0.0-[subView]-0.0-|" options:0 metrics:nil views:views];
    [superView addConstraints:viewConsH];
    
    // 纵向约束
    NSArray *viewConsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0.0-[subView]-0.0-|" options:0 metrics:nil views:views];
    [superView addConstraints:viewConsV];
}

@end
