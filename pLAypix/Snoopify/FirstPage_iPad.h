//
//  FirstPage_iPad.h
//  Snoopify
//
//  Created by Minakshi on 6/26/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<AVFoundation/AVAudioPlayer.h>
#import "AppDelegate.h"

@interface FirstPage_iPad : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate, UIDocumentInteractionControllerDelegate, AVAudioPlayerDelegate>
{
    
    UIImagePickerController *imagePicker;
    
    UIPopoverController *popoverController;
    
    UIImage *selectedImage;
    
    UIActivityViewController *activityViewController;
    
//    UIPopoverController *popover;
    
    //Sound
    
    AVAudioPlayer *buttonClickSound;
    
    AppDelegate *mainDelegate;
    
    float w, h;
    
}

@property(nonatomic, retain) UIImage *selectedImage;

@end
