//
//  XMMBConfigTool.h
//  XMMobileConfig
//
//  Created by chi on 15-6-4.
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

@class XMMBConfigModel;

@interface XMMBConfigTool : NSObject


/**
 *  配置文件路径，默认保存在tmp/XMMBConfWeb文件夹
 */
@property (nonatomic, copy) NSString *webConfigFolderPath;

/**
 *  将XMMBConfigModel放到http服务器请求
 */
- (BOOL)startHttpServerWithMBConfigModel:(XMMBConfigModel*)configModel configName:(NSString*)configName;

/**
 *  关掉HttpServer
 */
- (void)stopHttpServer;

/**
 *  httpServer是否在运行
 */
@property (nonatomic, assign, readonly) BOOL httpServerIsRunning;

#pragma mark - Class Factory

+ (instancetype)defaultXMMBConfigTool;


@end
