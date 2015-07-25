//
//  XMScannerView.h
//  XMScanner
//
//  Created by chi on 15-3-30.
//  Copyright (c) 2015年 chi. All rights reserved.
//
//  对MTBBarcodeScanner的简单封装
//

#import <UIKit/UIKit.h>

#import "MTBBarcodeScanner.h"

@interface XMScannerView : UIView

/**
 *  停止扫描
 */
- (void)stopScanning;


/**
 *  开始扫描
 *
 *  @param resultBlock 扫描结果回调
 */
- (void)startScanningWithResultBlock:(void (^)(NSArray *codes))resultBlock;




/**
 *  扫描区域大小
 */
@property (nonatomic, assign) CGSize scanAreaSize;

/**
 *  扫描区域距离上边的距离
 */
@property (nonatomic, assign) CGFloat scanAreaTopMargin;

/**
 *  显示扫描实时
 */
@property (nonatomic, assign) BOOL drawOverlaysOnCodes;


/**
 *  定时器时间
 */
@property (nonatomic, assign) CGFloat timerInterval;


/**
 *  检查设置有没有相机功能
 */
+ (BOOL)cameraIsPresent;

/**
 *  检查app是否被禁止访问相机
 */
+ (BOOL)scanningIsProhibited;


#pragma mark - 类工厂方法
/**
 *  获取实例
 *
 *  @param scanAreaSize        扫描区域大小
 *  @param metaDataObjectTypes 扫描支持的类型，为nil时默认支持全部
 *
 *  @return 实例
 */
+ (instancetype)xmScannerViewWithScanAreaSize:(CGSize)scanAreaSize metadataObjectTypes:(NSArray *)metaDataObjectTypes;

@end
