//
//  MainForm.h
//  XMMobileConfigDemo
//
//  Created by chi on 15-6-8.
//  Copyright (c) 2015年 chi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CustomWiFiForm.h"
#import "CustomWebClipForm.h"
#import "CustomAppAccessForm.h"

@interface MainForm : NSObject <FXForm>

@property (nonatomic, strong) CustomWiFiForm *WiFiCustom;

@property (nonatomic, strong) CustomWebClipForm *WebClip;

@property (nonatomic, strong) CustomAppAccessForm *AppAccess;

@end
