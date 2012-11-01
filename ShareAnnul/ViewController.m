//
//  ViewController.m
//  ShareAnnul
//
//  Created by Tuna Başaran on 10/31/12.
//  Copyright (c) 2012 Anıl Oruç. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize twitter = _twitter;
@synthesize facebook = _facebook;
@synthesize shareText = _shareText;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)share:(id)sender {
    
    [self.shareText resignFirstResponder];
    
    NSInteger temp = [self.shareText.text length];
    
    if (temp == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Hata" message:@"Lütfen paylaşılaçak alanı doldurunuz." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else
    {
        if (self.twitter.on) {
            if (temp>140) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Hata" message:@"Lütfen Tweet atabilmek için 140'tan az karakter giriniz." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            else
            {
                if ([TWTweetComposeViewController canSendTweet]) {
                    TWTweetComposeViewController *tweetSheed = [[TWTweetComposeViewController alloc]init];
                    
                    
                    
                    [tweetSheed setInitialText:self.shareText.text];
                    //[tweetSheed addURL:[NSURL URLWithString:@"www.arox.net"]];
                    //[tweetSheed addImage:[UIImage imageNamed:@"index.png"]];
                    [self presentModalViewController:tweetSheed animated:YES];
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tweet Hata" message:@"Tweet gönderilemiyor. Lütfen cihazınıza twitter hesabı ekleyin." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    //[alert release];
                }
                NSLog(@"Twitter paylaş");
            }
        }
        
        if (self.facebook.on) {
            
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                        
            [appDelegate openSessionWithAllowLoginUI:YES] ? [self populateUserDetails]: nil ;
            
            NSString * temp = @"www.arox.net";
            
            [self postTextFacebook:temp];
            
            NSLog(@"Yazı Gönderildi.");
           
            NSLog(@"Facebook paylaş");
        }
        
        self.shareText.text = @"";
    }
    
    
}

- (void)postTextFacebook:(NSString *)yazi
{
    FBRequestConnection *connection = [[FBRequestConnection alloc] init];
    
    FBRequest *request3 = [FBRequest requestForPostStatusUpdate:yazi];
    
    [connection addRequest:request3
         completionHandler:
     ^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error) {
         }
     }
            batchEntryName:@"textpost"
     ];
    FBRequest *request2 = [FBRequest
                           requestForGraphPath:@"{result=textpost:$.id}"];
    [connection addRequest:request2
         completionHandler:
     ^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error &&
             result) {
             NSString *source = [result objectForKey:@"source"];
             NSLog(@"%@",source);
             //[self postOpenGraphActionWithPhotoURL:source];
         }
     }
     ];
    
    [connection start];
}

- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
    }
}

- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 NSLog(@"Location: %@",user.location);
                 NSLog(@"Link: %@",user.link);
                 NSLog(@"Name: %@",user.name);
                 NSLog(@"Birthday: %@",user.birthday);
                 NSLog(@"First Name: %@",user.first_name);
                 NSLog(@"Middle Name: %@",user.middle_name);
                 NSLog(@"Last Name: %@",user.last_name);
                 NSLog(@"ID: %@",user.id);
                 NSLog(@"UserName: %@",user.username);
                 
                 //self.profilLabel.text = user.name;
                 //self.profilPic.profileID = user.id;
             }
         }];
                
        
        
            }
    else {
        
        
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
}


@end
