//
//  CustomWiFiForm.h
//  XMMobileConfigDemo
//
//  Created by chi on 15-6-8.
//  Copyright (c) 2015年 chi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomWiFiForm : NSObject <FXForm>

@property (nonatomic, copy) NSString *WiFiName;

@property (nonatomic, copy) NSString *WiFiPass;

@property (nonatomic, copy) NSString *PayloadOrganization;

@property (nonatomic, copy) NSString *PayloadDescription;

@property (nonatomic, copy) NSString *PayloadIdentifier;

@property (nonatomic, copy) NSString *PayloadDisplayName;

@end
