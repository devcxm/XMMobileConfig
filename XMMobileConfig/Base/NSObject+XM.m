//
//  NSObject+XM.m
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

#import "NSObject+XM.h"


NSString *const XMTypeBOOL = @"B";

#import <objc/runtime.h>

@implementation NSObject (XM)


/**
 *  枚举类成员变量
 *
 *  @param enumClass    遍历的类
 *  @param doSuperClass 是否需要遍历父类
 *  @param block        枚举block
 */
+ (void)enumerateClassVariablesWithClass:(Class)enumClass doSuperClass:(BOOL)doSuperClass usingBlock:(void (^)(NSString *vName, NSString *vType))block
{
    Class cls = enumClass;
    
    while (cls != [NSObject class])
    {
        unsigned int numberOfIvars = 0;
        Ivar* ivars = class_copyIvarList(cls, &numberOfIvars);//获取cls 类成员变量列表
        for(const Ivar* p = ivars; p < ivars+numberOfIvars; p++)//采用指针+1 来获取下一个变量
        {
            Ivar const ivar = *p;//取得这个变量
            NSString *vName = [NSString stringWithUTF8String:ivar_getName(ivar)];//取得这个变量的名称
            
            // 去除开头下划线"_"
            if (vName.length > 1) {
                vName = [vName substringFromIndex:1];
            }
            
            const char *type = ivar_getTypeEncoding(ivar); //取得这个变量的类型
            NSString *vType = [NSString stringWithUTF8String:type];
            
            if (block) {
                block(vName, vType);
            }
            
        }
        
        if (doSuperClass) {
            cls = class_getSuperclass(cls);
        }
        else {
            break;
        }
    }
}


@end
