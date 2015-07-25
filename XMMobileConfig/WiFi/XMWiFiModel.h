//
//  XMWiFiModel.h
//  XMMobileConfig
//
//  Created by chi on 15/5/13.
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
//
//  无线WiFi模型
//

#import <Foundation/Foundation.h>

#import "XMBasePayloadModel.h"

/**
 *  无线WiFi模型
 */
@interface XMWiFiModel : XMBasePayloadModel

/**
 *  WiFi名称
 */
@property (nonatomic, copy) NSString *SSID_STR;

/**
 *  加密类型
 */
@property (nonatomic, copy) NSString *EncryptionType;

/**
 *  是否是隐藏的网络
 */
@property (nonatomic, assign) BOOL HIDDEN_NETWORK;

/**
 *  WiFi密码
 */
@property (nonatomic, copy) NSString *Password;

/**
 *  自动加入网络
 */
@property (nonatomic, assign) BOOL AutoJoin;


#pragma mark - Proxy

#pragma mark - Proxy required

/**
 *  代理服务器
 */
@property (nonatomic, copy) NSString *ProxyServer;

/**
 *  代理端口
 */
@property (nonatomic, strong) NSNumber *ProxyServerPort;

/**
 *  代理设置:自动(Auto)/手动(Manual)
 */
@property (nonatomic, copy) NSString *ProxyType;

/**
 *  当ProxyType为Auto才需要设置的字段
 *  比如http://127.0.0.1:52901/proxy.pac
 */
@property (nonatomic, copy) NSString *ProxyPACURL;

#pragma mark - Proxy optional

/**
 *  用户名
 */
@property (nonatomic, copy) NSString *ProxyUsername;

/**
 *  密码
 */
@property (nonatomic, copy) NSString *ProxyPassword;



#pragma mark -
/**
 *  WIFI:S:wifimingcheng;T:WPA;P:wifimima;
 */
+ (instancetype)XMWiFiModelWithQRCodeString:(NSString*)qrCodeString;

@end
