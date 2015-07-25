//
//  MainViewController.m
//  XMMobileConfigDemo
//
//  Created by chi on 15/7/1.
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

#import "MainViewController.h"


#import "XMMobileConfig.h"

#pragma mark - controllers
#import "QRSCannerController.h"

#pragma mark - models
#import "MainForm.h"


@interface MainViewController ()

@end

@implementation MainViewController


#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"XMMobileConfig";
    
    self.formController.form = [[MainForm alloc]init];
}


#pragma mark - FXFormFieldAction

- (void)selectedCell:(UITableViewCell<FXFormFieldCell> *)cell
{
    NSString *key = cell.field.key;
    if ([key isEqualToString:@"WiFiFile"]) {
        XMMBConfigModel *mbConfig = [XMMBConfigModel XMMBConfigModelWithFilePath:[[NSBundle mainBundle] pathForResource:@"xmwifi.mobileconfig" ofType:nil]];
        
        [[XMMBConfigTool defaultXMMBConfigTool]startHttpServerWithMBConfigModel:mbConfig configName:mbConfig.PayloadIdentifier];
    }
    else if ([key isEqualToString:@"WiFiQRCode"]) {
        
        QRSCannerController *qrVc = [[QRSCannerController alloc]init];
        [self.navigationController pushViewController:qrVc animated:YES];
        
        qrVc.callBackBlock = ^(NSString *qrString){
            
            XMWiFiModel *wifiModel = [XMWiFiModel XMWiFiModelWithQRCodeString:qrString];
            
            if (wifiModel == nil) {
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid QR Code." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                
                return;
            }
            
            wifiModel.PayloadDisplayName = @"Test WiFi From QRCode";
            
            XMMBConfigModel *mbConfig = [XMMBConfigModel xmModelInstance];
            [mbConfig.PayloadContent addObject:wifiModel];
            mbConfig.PayloadIdentifier = @"com.devcxm.wifi.qrcode";
            mbConfig.PayloadDisplayName = @"XMWiFiConnecter QRCode Test";
            [[XMMBConfigTool defaultXMMBConfigTool]startHttpServerWithMBConfigModel:mbConfig configName:mbConfig.PayloadIdentifier];
            
        };
        
    }
    else if ([key isEqualToString:@"CustomWiFi"]) {
        
        CustomWiFiForm *wifiForm = cell.field.form;
        
        XMWiFiModel *wifiModel = [XMWiFiModel xmModelInstance];
        wifiModel.SSID_STR = wifiForm.WiFiName;
        wifiModel.Password = wifiForm.WiFiPass;
        wifiModel.PayloadDescription = wifiForm.PayloadDescription;
        wifiModel.PayloadDisplayName = wifiForm.PayloadDisplayName;
        wifiModel.PayloadIdentifier = wifiForm.PayloadIdentifier;
        wifiModel.PayloadOrganization = wifiForm.PayloadOrganization;
        
        
        XMMBConfigModel *mbConfig = [XMMBConfigModel xmModelInstance];
        [mbConfig.PayloadContent addObject:wifiModel];
        
        mbConfig.PayloadDescription = wifiForm.PayloadDescription;
        mbConfig.PayloadDisplayName = wifiForm.PayloadDisplayName;
        mbConfig.PayloadIdentifier = wifiForm.PayloadIdentifier;
        mbConfig.PayloadOrganization = wifiForm.PayloadOrganization;
        [[XMMBConfigTool defaultXMMBConfigTool]startHttpServerWithMBConfigModel:mbConfig configName:mbConfig.PayloadIdentifier];
    }
    else if ([key isEqualToString:@"WebClip"]) {
        
        CustomWebClipForm *webClipForm = cell.field.form;
        
        XMWebClipModel *webClipModel = [XMWebClipModel xmModelInstance];
        webClipModel.Icon = UIImagePNGRepresentation(webClipForm.Icon);
        webClipModel.URL = webClipForm.URL;
        webClipModel.Label = webClipForm.Label;
        webClipModel.IsRemovable = webClipForm.IsRemovable;
        webClipModel.Precomposed = webClipForm.Precomposed;
        webClipModel.FullScreen = webClipForm.FullScreen;
        
        XMMBConfigModel *mbConfig = [XMMBConfigModel xmModelInstance];
        [mbConfig.PayloadContent addObject:webClipModel];
        mbConfig.PayloadIdentifier = @"com.devcxm.webclip";
        [[XMMBConfigTool defaultXMMBConfigTool]startHttpServerWithMBConfigModel:mbConfig configName:mbConfig.PayloadIdentifier];
    }
    else if ([key isEqualToString:@"AppAccess"]) {
        CustomAppAccessForm *appAccessForm = cell.field.form;
        
        XMAppAccessModel *appAccessModel = [XMAppAccessModel xmModelInstance];
        appAccessModel.allowCamera = appAccessForm.allowCamera;
        appAccessForm.allowAppInstallation = appAccessForm.allowAppInstallation;
        appAccessForm.allowScreenShot = appAccessForm;
        
        XMMBConfigModel *mbConfig = [XMMBConfigModel xmModelInstance];
        [mbConfig.PayloadContent addObject:appAccessModel];
        mbConfig.PayloadIdentifier = @"com.devcxm.appaccess";
        [[XMMBConfigTool defaultXMMBConfigTool]startHttpServerWithMBConfigModel:mbConfig configName:mbConfig.PayloadIdentifier];
    }
    else {
        XMLog(@"%@", cell.field.key);
    }
}


@end
