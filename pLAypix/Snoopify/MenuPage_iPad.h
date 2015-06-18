//
//  MenuPage_iPad.h
//  Snoopify
//
//  Created by Minakshi on 6/27/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "MyUIView.h"
#import "MyUIImageView.h"
#import<AVFoundation/AVAudioPlayer.h>

@interface MenuPage_iPad : UIViewController<UIPopoverControllerDelegate, AVAudioPlayerDelegate, UIGestureRecognizerDelegate>
{
    UIImage *menuSelectedImage;
    
    UIPopoverController *popoverController;
    
    AppDelegate *mainDelegate;
    
    UIImageView *selectedImageView;
    
    CGFloat lastScale;
    CGFloat netrotation;
    
    UIImageView *background;
    
    UIButton *clearBtn;
    
    UIButton *newBtn;
    
    UIButton *shareBtn;
    
    UIButton *paletasBtn;
    
    MBProgressHUD *_hud;
    
    UIButton *trashBtn, *lastBtn, *copyBtn, *flipBtn, *doneBtn;
    
//    MyUIImageView *gestureView;
    
    NSMutableArray *addedTagsArray;
    
    int tagVar;
    
    BOOL tagEdited;
    
    UIImageView *selectedTag;
    
    //Sound
    
    AVAudioPlayer *buttonClickSound, *menuPageSound, *iceCreamManBtnSound;
    
    BOOL lastBtnFlag;
    
    float w, h;
    
//    MyUIImageView *gestureView;  
   
}
@property (retain) MBProgressHUD *hud;
@property(nonatomic, retain) UIImage *menuSelectedImage;
@property(nonatomic, retain) UIPopoverController *popoverController;



@end
