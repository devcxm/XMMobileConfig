//
//  CustomWebClipForm.m
//  XMMobileConfigDemo
//
//  Created by chi on 15-6-8.
//  Copyright (c) 2015年 chi. All rights reserved.
//

#import "CustomWebClipForm.h"

#import "XMWebClipModel.h"
#import "NSObject+XM.h"


@implementation CustomWebClipForm

- (instancetype)init
{
    if (self = [super init]) {
        self.FullScreen = YES;
        self.IsRemovable = YES;
        self.Precomposed = NO;
        
        self.Label = @"GitHubClip";
        self.URL = @"https://github.com/";
        self.Icon = [UIImage imageNamed:@"github.png"];
    }
    return self;
}

- (NSDictionary *)IconField
{
    return @{FXFormFieldType:FXFormFieldTypeImage, };
}


- (NSArray *)extraFields
{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [arrayM addObject:@{FXFormFieldKey:@"WebClip", FXFormFieldTitle: @"Submit", FXFormFieldHeader: @"", FXFormFieldAction:@"selectedCell:"}];
    
 
    return [arrayM copy];
}

@end
