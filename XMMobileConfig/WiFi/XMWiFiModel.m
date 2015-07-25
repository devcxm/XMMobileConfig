//
//  XMWiFiModel.m
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

#import "XMWiFiModel.h"


@implementation XMWiFiModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"\nEncryptionType=%@\nWiFiName=%@\nWiFiPassword=%@\n", self.EncryptionType, self.SSID_STR, self.Password];
}

#pragma mark - Life Cycle

- (instancetype)init
{
    if (self = [super init]) {
        self.EncryptionType = @"Any";
        self.HIDDEN_NETWORK = NO;
        self.PayloadType = kWiFiPayloadType;
        
        
        self.AutoJoin = @(YES);
    }
    
    return self;
}


#pragma mark - Class Factory

+ (instancetype)XMWiFiModelWithQRCodeString:(NSString *)qrCodeString
{
    XMWiFiModel *model = [[self alloc]init];
    
    NSRange startRange = [qrCodeString rangeOfString:@"WIFI:"];
    if (startRange.location == NSNotFound) {
        return nil;
    }
    
    NSRange endRange = [qrCodeString rangeOfString:@";" options:NSBackwardsSearch];
     
    
    if (endRange.location == NSNotFound) {
        return nil;
    }
    
    NSInteger wifiLocation = NSMaxRange(startRange);
    NSInteger wifiLength = endRange.location - wifiLocation;
    
    if (wifiLength < 1) {
        return nil;
    }

    NSString *wifiString = [qrCodeString substringWithRange:NSMakeRange(wifiLocation, wifiLength)];
    
    NSArray *keyValuesArray = [wifiString componentsSeparatedByString:@";"];
    
    for (NSString *keyValuesString in keyValuesArray) {
        NSArray *tmpArray = [keyValuesString componentsSeparatedByString:@":"];
        if (tmpArray.count == 2) {
            NSString *key = [tmpArray objectAtIndex:0];
            NSString *value = [tmpArray objectAtIndex:1];
            
            if ([key isEqualToString:@"S"]) {// wifi name
                model.SSID_STR = [value stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            }
            else if ([key isEqualToString:@"P"]) {// wifi pass
                model.Password = [value stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            }
//            else if ([key isEqualToString:@"T"]) {// wifi encryption
//                model.EncryptionType = [value stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//            }
        }
    }
    
    if (model.SSID_STR.length < 1 || model.Password.length < 1) {
        return nil;
    }
    
    
    return model;
}



@end
