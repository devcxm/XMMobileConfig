//
//  CustomWiFiForm.m
//  XMMobileConfigDemo
//
//  Created by chi on 15-6-8.
//  Copyright (c) 2015年 chi. All rights reserved.
//

#import "CustomWiFiForm.h"

#import "NSObject+XM.h"

#import "XMWiFiModel.h"


@implementation CustomWiFiForm


- (instancetype)init
{
    if (self = [super init]) {
        self.WiFiName = @"CustomWiFiName";
        self.WiFiPass = @"CustomWiFiPass";
        
        self.PayloadIdentifier = @"com.devcxm.wifi.custom";
        self.PayloadDisplayName = @"CustomDisplayName";
        self.PayloadDescription = @"MyDescription";
        self.PayloadOrganization = @"MyOrganization";
        
    }
    
    return self;
}


- (NSArray *)extraFields
{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [arrayM addObject:@{FXFormFieldKey:@"CustomWiFi", FXFormFieldTitle: @"Submit", FXFormFieldHeader: @"", FXFormFieldAction:@"selectedCell:"}];
 
    
    return [arrayM copy];
}

@end
