//
//  XMBasePayloadModel.m
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

#import "XMBasePayloadModel.h"

#import <objc/runtime.h>

#import "NSObject+XM.h"

@implementation XMBasePayloadModel

#pragma mark - Life Cycle

- (instancetype)init
{
    if (self = [super init]) {
        
        NSString *className = NSStringFromClass(self.class);
        
        self.PayloadDescription = [className stringByAppendingString:@"-PayloadDescription"];
        self.PayloadDisplayName = [className stringByAppendingString:@"-PayloadDisplayName"];
        self.PayloadOrganization = [className stringByAppendingString:@"-PayloadOrganization"];
        self.PayloadIdentifier = [@"com.devcxm." stringByAppendingString:className];
        
        self.PayloadUUID = [XMBasePayloadModel getUniqueStrByUUID];
        self.PayloadVersion = @(1);
    }
    
    return self;
}




#pragma mark - 

- (BOOL)isValid
{
    return YES;
}


#pragma mark - 字典操作
/**
 *  转换为字典
 */
- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    
    [NSObject enumerateClassVariablesWithClass:[self class] doSuperClass:YES usingBlock:^(NSString *vName, NSString *vType) {
        id objValue = [self valueForKey:vName];
        if (objValue) {
            [dictM setValue:objValue forKey:vName];
        }
        
    }];
    
    return [dictM copy];
}

#pragma mark - Class Factory

/**
 *  从字典实例化
 */
+ (instancetype)XMModelWithDictionary:(NSDictionary *)dict
{
    XMBasePayloadModel *model = [[self alloc]init];
    
    [NSObject enumerateClassVariablesWithClass:[self class] doSuperClass:YES usingBlock:^(NSString *vName, NSString *vType) {
        id obj = [dict valueForKey:vName];
        if (obj) {
            [model setValue:obj forKey:vName];
        }
        
    }];
    
    return model;
}


/**
 *  获取实例
 */
+ (instancetype)xmModelInstance
{
    XMBasePayloadModel *model = [[self alloc]init];
    return model;
}

#pragma mark -

/**
 *  获取UUID
 *
 *  @return UUID
 */
+ (NSString*)getUniqueStrByUUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    
    //get the string representation of the UUID
    
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    
    return uuidString;
}



@end

