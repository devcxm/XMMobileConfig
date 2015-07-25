//
//  CustomAppAccessForm.m
//  XMMobileConfigDemo
//
//  Created by chi on 15-7-25.
//  Copyright (c) 2015年 chi. All rights reserved.
//

#import "CustomAppAccessForm.h"

@implementation CustomAppAccessForm

- (instancetype)init
{
    if (self = [super init]) {
        self.allowAppInstallation = YES;
        self.allowScreenShot = YES;
    }
    
    return self;
}

- (NSDictionary *)MoreInfoField
{
    return @{@"textLabel.color": [UIColor lightGrayColor], @"textLabel.font": [UIFont systemFontOfSize:15.0f]};
}

- (NSArray *)extraFields
{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [arrayM addObject:@{FXFormFieldKey:@"MoreInfo", FXFormFieldType:FXFormFieldTypeDefault, FXFormFieldTitle: @"Check XMAccessModel For More Configs",}];
    
    [arrayM addObject:@{FXFormFieldKey:@"AppAccess", FXFormFieldTitle: @"Submit", FXFormFieldHeader: @"", FXFormFieldAction:@"selectedCell:"}];
    
    
    return [arrayM copy];
}

@end
