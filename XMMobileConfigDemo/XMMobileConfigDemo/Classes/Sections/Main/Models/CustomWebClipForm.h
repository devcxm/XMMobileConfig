//
//  CustomWebClipForm.h
//  XMMobileConfigDemo
//
//  Created by chi on 15-6-8.
//  Copyright (c) 2015年 chi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomWebClipForm : NSObject <FXForm>


@property (nonatomic, copy) NSString *Label;

@property (nonatomic, copy) NSString *URL;

@property (nonatomic, assign) BOOL FullScreen;

@property (nonatomic, assign) BOOL IsRemovable;

@property (nonatomic, strong) UIImage *Icon;

@property (nonatomic, assign) BOOL Precomposed;


@end
