//
//  ViewController.h
//  ShareAnnul
//
//  Created by Tuna Başaran on 10/31/12.
//  Copyright (c) 2012 Anıl Oruç. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <FacebookSDK/FacebookSDK.h>
#import <FacebookSDK/FBProfilePictureView.h>
#import <FacebookSDK/FBGraphUser.h>

@interface ViewController : UIViewController <FBRequestDelegate>

@property (strong, nonatomic) IBOutlet UITextField * shareText;

@property (strong, nonatomic) IBOutlet UISwitch * twitter;

@property (strong, nonatomic) IBOutlet UISwitch * facebook;

- (IBAction)share:(id)sender;

- (void)postTextFacebook:(NSString *)yazi;

- (void)sessionStateChanged:(NSNotification*)notification;

@end
