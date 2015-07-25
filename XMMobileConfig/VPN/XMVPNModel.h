//
//  XMVPNModel.h
//  XMMobileConfig
//
//  Created by chi on 15/6/4.
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

//  VPN配置,待完善

#import "XMBasePayloadModel.h"

@interface EAPModel : NSObject

@property (nonatomic, strong) NSNumber *OverridePrimary;

@end


@interface PPPModel : NSObject

/**
 *  服务器地址
 */
@property (nonatomic, copy) NSString *CommRemoteAddress;

/**
 *  帐户名称
 */
@property (nonatomic, copy) NSString *AuthName;


@property (nonatomic, strong) NSNumber *CCPEnabled;

@property (nonatomic, strong) NSNumber *CCPMPPE128Enabled;

@property (nonatomic, strong) NSNumber *CCPMPPE40Enabled;



@end


@interface VPNProxiesModel : NSObject


#pragma mark - user

@property (nonatomic, copy) NSString *HTTPProxyUsername;

@property (nonatomic, copy) NSString *HTTPProxyPassword;

#pragma mark - http
@property (nonatomic, strong) NSNumber *HTTPEnable;

@property (nonatomic, strong) NSNumber *HTTPPort;

@property (nonatomic, copy) NSString *HTTPProxy;

#pragma mark - https
@property (nonatomic, strong) NSNumber *HTTPSEnable;

@property (nonatomic, strong) NSNumber *HTTPSPort;

@property (nonatomic, copy) NSString *HTTPSProxy;

@end

@interface XMVPNModel : XMBasePayloadModel


@property (nonatomic, strong) EAPModel *EAP;


@property (nonatomic, strong) PPPModel *PPP;

/**
 *  连接名称
 */
@property (nonatomic, copy) NSString *UserDefinedName;

/**
 *  VPN类型 e.g. PPTP,L2TP

 */
@property (nonatomic, copy) NSString *VPNType;

/**
 *  代理
 */
@property (nonatomic, strong) VPNProxiesModel *Proxies;

@end
