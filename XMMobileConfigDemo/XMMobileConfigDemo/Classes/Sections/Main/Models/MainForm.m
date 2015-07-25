//
//  MainForm.m
//  XMMobileConfigDemo
//
//  Created by chi on 15-6-8.
//  Copyright (c) 2015年 chi. All rights reserved.
//

#import "MainForm.h"


@implementation MainForm


- (NSArray *)fields
{
    return @[
             @{FXFormFieldKey:@"WiFiFile", FXFormFieldTitle:@"Load From File", FXFormFieldViewController: [UIViewController class],FXFormFieldAction:@"selectedCell:", FXFormFieldHeader:@"WiFi Mobile Config"},
             @{FXFormFieldKey:@"WiFiQRCode", FXFormFieldTitle:@"Load From QRCode", FXFormFieldViewController:[UIViewController class], FXFormFieldAction:@"selectedCell:"},
             @{FXFormFieldKey:@"WiFiCustom", FXFormFieldTitle:@"Custom WiFi", },
 
             @{FXFormFieldKey:@"WebClip", FXFormFieldTitle:@"Web Clip", FXFormFieldHeader:@"Web Clip Mobile Config"},
             
             @{FXFormFieldKey:@"AppAccess", FXFormFieldTitle:@"App Access", FXFormFieldHeader:@"App Access Mobile Config"},
             ];
}

@end
