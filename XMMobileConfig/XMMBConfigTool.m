//
//  XMMBConfigTool.m
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

#import "XMMBConfigTool.h"

#pragma mark - CocoaHTTPServer
#import <CocoaHTTPServer/HTTPServer.h>
#import <CocoaLumberjack/DDTTYLogger.h>
#import <CocoaLumberjack/DDLog.h>

#import "XMMBConfigModel.h"

@interface XMMBConfigTool ()
{
    BOOL _httpServerIsRunning;
}

/**
 *  http服务器
 */
@property (nonatomic, strong) HTTPServer *httpServer;

@end

@implementation XMMBConfigTool
- (instancetype)init
{
    if (self = [super init]) {
        _httpServerIsRunning = NO;
    }
    
    return self;
}

/**
 *  将XMMBConfigModel放到http服务器请求
 */
- (BOOL)startHttpServerWithMBConfigModel:(XMMBConfigModel*)configModel configName:(NSString*)configName
{
    
    // 将XMMBConfigModel存储到web文件夹
    NSString *saveName = [configName stringByAppendingPathExtension:@"mobileconfig"];
    BOOL saveSuccess = [configModel saveMBConifgModelToFile:[self.webConfigFolderPath stringByAppendingPathComponent:saveName]];
    
    if (!saveSuccess) {
        return NO;
    }
    
    // 先移除之前的httpServer
    [self stopHttpServer];
    
    // 新建HttpServer
    NSError *error = nil;
    if([self.httpServer start:&error])
    {
        XMLog(@"Started HTTP Server on port %hu", [self.httpServer listeningPort]);
        
        _httpServerIsRunning = YES;
    }
    else
    {
        XMLog(@"Error starting HTTP Server: %@", error);
    }
    
    
    
    
    // 用safari浏览器打开mobileconfig
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:%u/%@", self.httpServer.listeningPort, saveName];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    
    return YES;
}

/**
 *  关掉HttpServer
 */
- (void)stopHttpServer
{
    _httpServerIsRunning = NO;
    if (_httpServer) {
        [_httpServer stop:YES];
        _httpServer = nil;
    }
}

- (BOOL)httpServerIsRunning
{
    return _httpServerIsRunning;
}

#pragma mark - Lazy Initializer

- (NSString *)webConfigFolderPath
{
    if (_webConfigFolderPath == nil) {
        _webConfigFolderPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"XMMBConfWeb"];
        // 创建文件夹
        [[NSFileManager defaultManager]createDirectoryAtPath:_webConfigFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return _webConfigFolderPath;
}

- (HTTPServer *)httpServer
{
    if (_httpServer == nil) {
        _httpServer = [[HTTPServer alloc]init];
        [_httpServer setType:@"_http._tcp."];
        [_httpServer setDocumentRoot:self.webConfigFolderPath];
        
    }
    
    return _httpServer;
}


#pragma mark - Class Factory

+ (instancetype)defaultXMMBConfigTool
{
    static XMMBConfigTool *s_tool = nil;
    
    if (s_tool == nil) {
        s_tool = [[self alloc]init];
    }
    
    return s_tool;
}

@end
