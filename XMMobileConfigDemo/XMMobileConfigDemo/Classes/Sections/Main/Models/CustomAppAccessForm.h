//
//  CustomAppAccessForm.h
//  XMMobileConfigDemo
//
//  Created by chi on 15-7-25.
//  Copyright (c) 2015年 chi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomAppAccessForm : NSObject <FXForm>


/**
 *  允许安装应用程序
 */
@property (nonatomic, assign) BOOL allowAppInstallation;

/**
 *  允许使用相机
 */
@property (nonatomic, assign) BOOL allowCamera;

/**
 *  允许屏幕捕捉
 */
@property (nonatomic, assign) BOOL allowScreenShot;


@end
