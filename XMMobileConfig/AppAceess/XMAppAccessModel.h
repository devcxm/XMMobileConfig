//
//  XMAppAccessModel.h
//  XMMobileConfig
//
//  Created by chi on 15/7/21.
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
//
//  设备限制
//

#import "XMBasePayloadModel.h"




@interface XMAppAccessModel : XMBasePayloadModel

#pragma mark - 设备功能

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

/**
 *  允许在漫游时自动同步
 */
@property (nonatomic, assign) BOOL allowGlobalBackgroundFetchWhenRoaming;

/**
 *  允许Siri
 */
@property (nonatomic, assign) BOOL allowAssistant;
/**
 *  设备锁定时允许使用Siri
 */
@property (nonatomic, assign) BOOL allowAssistantWhileLocked;

/**
 *  允许语音拔号
 */
@property (nonatomic, assign) BOOL allowVoiceDialing;

/**
 *  允许应用序列内购买
 */
@property (nonatomic, assign) BOOL allowInAppPurchases;

/**
 *  强制用户为所有购买项目输入iTunes Store密码
 */
@property (nonatomic, assign) BOOL forceITunesStorePasswordEntry;

/**
 *  允许多人游戏
 */
@property (nonatomic, assign) BOOL allowMultiplayerGaming;

/**
 *  允许添加GameCenter朋友
 */
@property (nonatomic, assign) BOOL allowAddingGameCenterFriends;


/**
 *  允许视频会议
 */
@property (nonatomic, assign) BOOL allowVideoConferencing;

#pragma mark - 应用程序
/**
 *  允许使用YouTube
 */
@property (nonatomic, assign) BOOL allowYouTube;
/**
 *  允许使用iTunes Store
 */
@property (nonatomic, assign) BOOL allowiTunes;
/**
 *  允许使用Safari
 */
@property (nonatomic, assign) BOOL allowSafari;

/**
 *  启用自动填充
 */
@property (nonatomic, assign) BOOL safariAllowAutoFill;

/**
 *  强制发出欺骗警告
 */
@property (nonatomic, assign) BOOL safariForceFraudWarning;

/**
 *  允许JaveScript
 */
@property (nonatomic, assign) BOOL safariAllowJavaScript;

/**
 *  阻止弹出式窗口
 */
@property (nonatomic, assign) BOOL safariAllowPopups;

/**
 *  接受Cookie
 */
@property (nonatomic, strong) NSNumber *safariAcceptCookies;



#pragma mark - iCloud
/**
 *  允许备份
 */
@property (nonatomic, assign) BOOL allowCloudBackup;
/**
 *  允许文稿同步
 */
@property (nonatomic, assign) BOOL allowCloudDocumentSync;

/**
 *  允许照片流
 */
@property (nonatomic, assign) BOOL allowPhotoStream;

#pragma mark - 安全和隐私
/**
 *  允许向Apple发送诊断数据
 */
@property (nonatomic, assign) BOOL allowDiagnosticSubmission;
/**
 *  允许用户接受不被信任的TLS证书
 */
@property (nonatomic, assign) BOOL allowUntrustedTLSPrompt;
/**
 *  强制对备份进行加密
 */
@property (nonatomic, assign) BOOL forceEncryptedBackup;


#pragma mark - 内容评级

/**
 *  允许不良音乐和Podcast
 */
@property (nonatomic, assign) BOOL allowExplicitContent;

/**
 *  评级地区
 */
@property (nonatomic, copy) NSString *ratingRegion;

/**
 *  评级应用程序级别
 */
@property (nonatomic, strong) NSNumber *ratingApps;
/**
 *  评级电视节目级别
 */
@property (nonatomic, strong) NSNumber *ratingTVShows;
/**
 *  评级影片级别
 */
@property (nonatomic, strong) NSNumber *ratingMovies;



@end
