//
//  QRSCannerController.m
//  XMMobileConfigDemo
//
//  Created by chi on 15-5-13.
//  Copyright (c) 2015年 chi. All rights reserved.
//
//The MIT License (MIT)
//
//Copyright (c) 2015 devcxm <devcxm@qq.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.


#import "QRSCannerController.h"

#import <AudioToolbox/AudioToolbox.h>

#import <FXForms/FXForms.h>

#import "XMScannerView.h"

@interface QRSCannerController ()

/**
 *  扫描二维码视图
 */
@property (nonatomic, weak) XMScannerView *scannerView;

/**
 *  加载指示器
 */
@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;

@end

@implementation QRSCannerController


#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f];
    
    self.title = @"QR Scanner";
    
    // 创建视图
    [self setup];

    [self.indicatorView startAnimating];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.scannerView.hidden = NO;
    [self.scannerView startScanningWithResultBlock:^(NSArray *codes) {
        for (AVMetadataMachineReadableCodeObject *code in codes) {
            if (code.stringValue.length > 0) {
                [self.scannerView stopScanning];
                self.scannerView.hidden = YES;
                [self.indicatorView startAnimating];
                
                AudioServicesPlaySystemSound(1007);
                
                if (self.callBackBlock) {
                    self.callBackBlock(code.stringValue);
                }
                
                
                [self.navigationController popViewControllerAnimated:YES];
                
                
                break;
            }
        }
    }];
    
    [self.indicatorView stopAnimating];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.scannerView stopScanning];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    //    CGFloat height = CGRectGetHeight(self.view.bounds);

    if (width > 700.0) {
        // 设置扫描区域大小
        self.scannerView.scanAreaSize = CGSizeMake(500.0f, 500.0f);
        self.scannerView.scanAreaTopMargin = 200.0f;
    }
    else {

        // 设置扫描区域大小
        self.scannerView.scanAreaSize = CGSizeMake(300.0f, 300.0f);
        self.scannerView.scanAreaTopMargin = 100.0f;
    }
    
}


#pragma mark - FXForms Method

- (void)setField:(FXFormField*)field{
}

#pragma mark - Setup Method

- (void)setup
{
    XMScannerView *scannerView = [XMScannerView xmScannerViewWithScanAreaSize:CGSizeZero metadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    scannerView.hidden = YES;
    self.scannerView = scannerView;
    [self.view addSubview:scannerView];
    scannerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // AL
    NSArray *consH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0.0-[scannerView]-0.0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scannerView)];
    [self.view addConstraints:consH];
    
    NSArray *consV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0.0-[scannerView]-0.0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scannerView)];
    [self.view addConstraints:consV];
 
}


#pragma mark - Lazy Initializer
- (UIActivityIndicatorView *)indicatorView
{
    if (_indicatorView == nil) {
        UIActivityIndicatorView *indicatorView =  [[UIActivityIndicatorView alloc]init];
        [self.view addSubview:indicatorView];
        _indicatorView = indicatorView;
        indicatorView.hidesWhenStopped = YES;
        
        //Center AutoLayout
        indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *conCenterX = [NSLayoutConstraint constraintWithItem:indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:indicatorView.superview attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
        [self.view addConstraint:conCenterX];
        NSLayoutConstraint *conCenterY = [NSLayoutConstraint constraintWithItem:indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:indicatorView.superview attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
        [self.view addConstraint:conCenterY];
        
    }
    return _indicatorView;
}


@end
