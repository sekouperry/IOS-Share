//
//  AppDelegate.h
//  ShareAnnul
//
//  Created by Tuna Başaran on 10/31/12.
//  Copyright (c) 2012 Anıl Oruç. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

extern NSString *const FBSessionStateChangedNotification;

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) NSError * error;

@property (nonatomic, strong) FBSession *session;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

@end
