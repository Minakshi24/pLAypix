//
//  AppDelegate.h
//  Snoopify
//
//  Created by Minakshi on 6/26/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<AVFoundation/AVAudioPlayer.h>
#import "SharePage_iPad.h"

@class FirstPage_iPad;

@interface AppDelegate : UIResponder <UIApplicationDelegate, AVAudioPlayerDelegate>
{
    UIImage *selectedImageFromTagPage;
    
    AVAudioPlayer *startupSound;
    
    BOOL migoBtnFlag;
    
    SharePage_iPad *sharePageObj;
    
    BOOL gestureFlag, singleTapFlag;
    
    BOOL isUserInterActionEnabled;
    
    BOOL newFlag;
    
}

@property BOOL newFlag;

@property BOOL isUserInterActionEnabled;

@property BOOL migoBtnFlag;

@property BOOL gestureFlag;

@property BOOL singleTapFlag;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FirstPage_iPad *viewController;

@property (nonatomic, retain) UIImage *selectedImageFromTagPage;

@property (nonatomic, retain) SharePage_iPad *sharePageObj;

@end
