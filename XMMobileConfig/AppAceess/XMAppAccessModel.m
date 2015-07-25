//
//  XMAppAccessModel.m
//  XMMobileConfig
//
//  Created by chi on 15/7/21.
//  Copyright (c) 2015年 chi. All rights reserved.
//
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

#import "XMAppAccessModel.h"

@implementation XMAppAccessModel


- (instancetype)init
{
    if (self = [super init]) {
        

        self.PayloadType = kAppAccessPayloadType;
        
        
        //子类属性
        self.allowAppInstallation = YES;
        self.allowCamera = YES;
        self.allowScreenShot = YES;
        self.allowGlobalBackgroundFetchWhenRoaming = YES;
        self.allowAssistant = YES;
        self.allowAssistantWhileLocked = YES;
        self.allowVoiceDialing = YES;
        self.allowInAppPurchases = YES;
        self.forceITunesStorePasswordEntry = NO;
        self.allowMultiplayerGaming = YES;
        self.allowAddingGameCenterFriends = YES;
        self.allowVideoConferencing = YES;
        self.allowYouTube = YES;
        self.allowiTunes = YES;
        self.allowSafari = YES;
        self.safariAllowAutoFill = YES;
        self.safariForceFraudWarning = NO;
        self.safariAllowJavaScript = YES;
        self.safariAllowPopups = NO;
        self.safariAcceptCookies = @2;
        self.allowCloudBackup = YES;
        self.allowCloudDocumentSync = YES;
        self.allowPhotoStream = YES;
        self.allowDiagnosticSubmission = YES;
        self.allowUntrustedTLSPrompt = YES;
        self.forceEncryptedBackup = NO;
        self.allowExplicitContent = NO;
        self.ratingRegion = @"us";
        self.ratingApps = @1000;
        self.ratingTVShows = @1000;
        self.ratingMovies = @1000;
    }
    
    return self;
}

@end
