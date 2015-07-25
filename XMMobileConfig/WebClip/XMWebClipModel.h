//
//  XMWebClipModel.h
//  XMMobileConfig
//
//  Created by chi on 15/6/4.
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

#import "XMBasePayloadModel.h"

@interface XMWebClipModel : XMBasePayloadModel

/**
 *  全屏
 */
@property (nonatomic, assign) BOOL FullScreen;


/**
 *  图标
 */
@property (nonatomic, strong) NSData *Icon;


/**
 *  是否可移除
 */
@property (nonatomic, assign) BOOL IsRemovable;


/**
 *  显示名称
 */
@property (nonatomic, copy) NSString *Label;


/**
 *  预作图标,显示图标时将不添加视觉效果
 */
@property (nonatomic, assign) BOOL Precomposed;


/**
 *  链接地址
 */
@property (nonatomic, copy) NSString *URL;


@end
