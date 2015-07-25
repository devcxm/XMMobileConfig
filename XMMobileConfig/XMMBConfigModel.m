//
//  XMMBConfigModel.m
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

#import "XMMBConfigModel.h"

#import "NSObject+XM.h"

#import "XMWiFiModel.h"
#import "XMWebClipModel.h"
#import "XMVPNModel.h"
#import "XMAppAccessModel.h"


@implementation XMMBConfigModel

#pragma mark - Life Cycle

- (instancetype)init
{
    if (self = [super init]) {
        self.PayloadType = @"Configuration";
        self.PayloadRemovalDisallowed = NO;
    }
    
    return self;
}

/**
 *  将配置保存至文件
 *
 *  @param savePath 保存路径
 */
- (BOOL)saveMBConifgModelToFile:(NSString*)savePath
{
    NSDictionary *saveDict = [self toDictionary];
    return [saveDict writeToFile:savePath atomically:YES];
}

#pragma mark - Lazy Initializer

- (NSMutableArray *)PayloadContent
{
    if (_PayloadContent == nil) {
        _PayloadContent = [NSMutableArray array];
    }
    
    
    return _PayloadContent;
}

#pragma mark - Class Factory

/**
 *  从文件读取
 *
 *  @param filePath .mobileconfig路径
 *
 *  @return 从文件读取的配置文件实例
 */
+ (instancetype)XMMBConfigModelWithFilePath:(NSString*)filePath
{
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        return nil;
    };
    
    NSDictionary *fileDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (fileDict == nil) {
        return nil;
    }
    
    XMMBConfigModel *config = [[self alloc]init];
    
    [NSObject enumerateClassVariablesWithClass:[self class] doSuperClass:YES usingBlock:^(NSString *vName, NSString *vType) {
        
        id objVale = [fileDict valueForKey:vName];
        if (objVale) {
            if (![vName isEqualToString:@"PayloadContent"]) {
                [config setValue:objVale forKey:vName];
            }
        }

        
    }];

    NSArray *PayloadContentArray = [fileDict valueForKey:@"PayloadContent"];
    
    if (PayloadContentArray.count > 0) {
        NSMutableArray *arrayMT = [NSMutableArray arrayWithCapacity:PayloadContentArray.count];
        for (NSDictionary *dict in PayloadContentArray) {
            XMBasePayloadModel *model = nil;
            NSString *PayloadType = [dict objectForKey:@"PayloadType"];
            if ([PayloadType isEqualToString:kWiFiPayloadType]) {
                model = [XMWiFiModel XMModelWithDictionary:dict];
            }
            else if ([PayloadType isEqualToString:kAppAccessPayloadType]) {
                model = [XMAppAccessModel XMModelWithDictionary:dict];
            }
            else if ([PayloadType isEqualToString:kWebClipPayloadType]) {
                model = [XMWebClipModel XMModelWithDictionary:dict];
            }
            
            if (model) {
                [arrayMT addObject:model];
            }
            
            
        }
        [config.PayloadContent addObjectsFromArray:arrayMT];
    }

    return config;

 }


#pragma mark - 字典操作
/**
 *  转换为字典
 */
- (NSDictionary*)toDictionary
{
    
    NSArray *PayloadContentArray = [self PayloadContentToDictionaryArray];
    
    if (PayloadContentArray == nil) {
        return nil;
    }
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    
    [NSObject enumerateClassVariablesWithClass:[self class] doSuperClass:YES usingBlock:^(NSString *vName, NSString *vType) {
       
        if (![vName isEqualToString:@"PayloadContent"]) {
            [dictM setValue:[self valueForKey:vName] forKey:vName];
        }
        
    }];
    
    
    [dictM setValue:PayloadContentArray forKey:@"PayloadContent"];
  
    return dictM;
}

/**
 *  将PayloadContent转换为字典数组
 *
 *  @return PayloadContent字典数组
 */
- (NSArray*)PayloadContentToDictionaryArray
{
    if (_PayloadContent.count < 1) {
        return nil;
    }
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:_PayloadContent.count];
    
    for (XMBasePayloadModel *baseModel in _PayloadContent) {
        if ([baseModel isValid]) {
            [arrayM addObject:[baseModel toDictionary]];
        }
    }
    
    return [arrayM copy];
}


@end
