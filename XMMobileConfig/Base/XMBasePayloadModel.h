//
//  XMBasePayloadModel.h
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



#import <Foundation/Foundation.h>


#define kAppAccessPayloadType (@"com.apple.applicationaccess")
#define kWebClipPayloadType (@"com.apple.webClip.managed")
#define kWiFiPayloadType (@"com.apple.wifi.managed")

@interface XMBasePayloadModel : NSObject

/**
 *  描述
 */
@property (nonatomic, copy) NSString *PayloadDescription;

/**
 *  机构
 */
@property (nonatomic, copy) NSString *PayloadOrganization;

/**
 *  显示名称
 */
@property (nonatomic, copy) NSString *PayloadDisplayName;


/**
 *  标识
 */
@property (nonatomic, copy) NSString *PayloadIdentifier;


/**
 *  唯一标识符
 */
@property (nonatomic, copy) NSString *PayloadUUID;

/**
 *  版本
 */
@property (nonatomic, strong) NSNumber *PayloadVersion;


/**
 *  类型
 */
@property (nonatomic, copy) NSString *PayloadType;

#pragma mark -

/**
 *  获取实例
 */
+ (instancetype)xmModelInstance;

/**
 *  转换为字典
 */
- (NSDictionary*)toDictionary;


/**
 *  从字典实例化
 */
+ (instancetype)XMModelWithDictionary:(NSDictionary*)dict;

/**
 *  是否有效的模型
 */
- (BOOL)isValid;


#pragma mark -
/**
 *  获取UUID
 *
 *  @return UUID
 */
+ (NSString*)getUniqueStrByUUID;

@end
