//
//  SharePage_iPad.h
//  pLAypix
//
//  Created by Minakshi on 7/3/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import<AVFoundation/AVAudioPlayer.h>
//#import "AppDelegate.h"

@class AppDelegate;

@interface SharePage_iPad : UIViewController <UIWebViewDelegate, UIDocumentInteractionControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, AVAudioPlayerDelegate>
{
    
    UIImage *finalImage;
    
    MBProgressHUD * hud1;
    
    UIDocumentInteractionController *dic;
    
    SLComposeViewController *mySLComposerSheet;
    ALAssetsLibrary* library;
    
    AVAudioPlayer *buttonClickSound;
    
    AppDelegate *mainDelegate;
    
    float w, h;
    
    UIImage *backImage;
    
}

@property (nonatomic, retain) UIImage *backImage;

@property (nonatomic, retain) UIImage *finalImage;

@property (nonatomic, retain) UIDocumentInteractionController *dic;

@property (strong, atomic) ALAssetsLibrary* library;

-(void)shareImageOnInstagram:(UIImage*)shareImage;

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;


@end
