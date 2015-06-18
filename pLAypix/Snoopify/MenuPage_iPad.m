//
//  MenuPage_iPad.m
//  Snoopify
//
//  Created by Minakshi on 6/27/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "MenuPage_iPad.h"
#import "TagsPage_iPad.h"
#import "UIImage+MyImage.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "SharePage_iPad.h"
#import "MyUIView.h"
#import "common.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface MenuPage_iPad ()

@end

@implementation MenuPage_iPad

@synthesize menuSelectedImage, popoverController;

#pragma mark - UIViewController Delegate Methods

//-(void)viewWillAppear:(BOOL)animated
//{
//    
//    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    paletasBtn.selected = NO;
//    
//    if(mainDelegate.selectedImageFromTagPage != nil)
//    {
//        
//        tagEdited = TRUE;
//        
//        if(addedTagsArray == nil)
//        {
//            addedTagsArray = [[NSMutableArray alloc] init];
//        }
//        
//        //menuPageBgSelectediPad.png
//        background.image = [UIImage imageNamed:@"Ref1.png"];
//        
//        //Menu 1 Buttons Disabled
//        newBtn.hidden = YES;
//        newBtn.enabled = NO;
//        
//        paletasBtn.hidden = YES;
//        paletasBtn.enabled = NO;
//        
//        shareBtn.hidden = YES;
//        shareBtn.enabled = NO;
//        
//        //Menu 2 Buttons Enabled
//        trashBtn.hidden = NO;
//        trashBtn.enabled = YES;
//        [self.view bringSubviewToFront:trashBtn];
//        
//        lastBtn.hidden = NO;
//        lastBtn.enabled = YES;
//        [self.view bringSubviewToFront:lastBtn];
//        
//        copyBtn.hidden = NO;
//        copyBtn.enabled = YES;
//        [self.view bringSubviewToFront:copyBtn];
//        
//        flipBtn.hidden = NO;
//        flipBtn.enabled = YES;
//        [self.view bringSubviewToFront:flipBtn];
//        
//        doneBtn.hidden = NO;
//        doneBtn.enabled = YES;
//        [self.view bringSubviewToFront:doneBtn];
//        
//        float viewX = (4000-671)/2;
//        float viewY = (4080-663)/2;
//        
//        MyUIView *gestureView = [[MyUIView alloc] init];
//        gestureView.tag = tagVar + 2000;
//        gestureView.frame = CGRectMake(-viewX, -viewY, 4000, 4080);
//        gestureView.backgroundColor = [UIColor clearColor];
//        gestureView.exclusiveTouch = YES;
//        gestureView.userInteractionEnabled = YES;
//        
//        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
//        panGesture.delegate = self;
//        [gestureView addGestureRecognizer:panGesture];
//        [panGesture addTarget:self action:@selector(dragging:)];
//
//        UIPinchGestureRecognizer *mypinch = [ [UIPinchGestureRecognizer alloc] init];
//        mypinch.delegate = self;
//        [mypinch addTarget:self action:@selector(myevent:)];
//        [gestureView addGestureRecognizer:mypinch];
//        
//        UIRotationGestureRecognizer *rotateGesture = [ [UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(MyRotationEvent:)];
//        rotateGesture.delegate = self;
//        [gestureView addGestureRecognizer:rotateGesture];
//        
//        [selectedImageView addSubview:gestureView];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
//        
//        float imgX = gestureView.frame.size.width/2 - 167/2;
//        float imgY = gestureView.frame.size.height/2 - 175/2;
//        
//        float tagImageWidth = mainDelegate.selectedImageFromTagPage.size.width;
//        float tagImageHeight = mainDelegate.selectedImageFromTagPage.size.height;
//        
//        float tempVar = 260;
//        
//        while(1)
//        {
//            tagImageWidth = tempVar;//tagImageWidth/2;
//            tagImageHeight = tempVar*mainDelegate.selectedImageFromTagPage.size.height/mainDelegate.selectedImageFromTagPage.size.width;//tagImageHeight/2;
//            
//            DLog(@"tagImageWidth : %f tagImageHeight : %f",tagImageWidth, tagImageHeight);
//            
//            if(tagImageHeight < 300)
//            {
//                break;
//            }
//            else
//            {
//                tempVar = tempVar - 10;
//                continue;
//            }
//        }
//        
//        DLog(@"%@", mainDelegate.selectedImageFromTagPage.accessibilityIdentifier);
//
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.frame = CGRectMake(imgX, imgY, 280, 300);
////        imageView.tag = tagVar;
//        imageView.backgroundColor = [UIColor clearColor];
//        imageView.userInteractionEnabled = YES;
//        imageView.layer.borderColor = [[UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:214.0/255.0 alpha:1.0] CGColor];
//        imageView.layer.borderWidth = 2.0;
//        [imageView setAccessibilityIdentifier:mainDelegate.selectedImageFromTagPage.accessibilityIdentifier];
//        [gestureView addSubview:imageView];
//        
//        float imgXX = imageView.frame.size.width/2 - tagImageWidth/2;
//        float imgYY = imageView.frame.size.height/2 - tagImageHeight/2;
//        
//        UIImageView *originalImage = [[UIImageView alloc] initWithImage:mainDelegate.selectedImageFromTagPage];
//        originalImage.backgroundColor = [UIColor clearColor];
//        originalImage.tag = tagVar;
//        originalImage.frame = CGRectMake(imgXX, imgYY, tagImageWidth, tagImageHeight);
//        originalImage.userInteractionEnabled = YES;
//        [originalImage setAccessibilityIdentifier:mainDelegate.selectedImageFromTagPage.accessibilityIdentifier];
//        [imageView addSubview:originalImage];
//        
//        DLog(@" imageView : %f %f" , imageView.center.x, imageView.center.x);
//        
//        DLog(@"originalImage : %f %f" , originalImage.center.x, originalImage.center.x);
//        
//        tagVar++;
//        
//        selectedTag = imageView;
//        [selectedTag setAccessibilityIdentifier:imageView.accessibilityIdentifier];
//        
//        [addedTagsArray addObject:imageView];
//        
//        DLog(@"%@", selectedTag.accessibilityIdentifier);
//        
//        mainDelegate.selectedImageFromTagPage = nil;
//        
//        [self.view bringSubviewToFront:background];
//        [self.view bringSubviewToFront:clearBtn];
//        
//        [selectedImageView bringSubviewToFront:gestureView];
//        
//    }
//}

-(void)viewWillAppear:(BOOL)animated
{
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    paletasBtn.selected = NO;
    //paletasBtn.frame = CGRectMake(125, 380, 152/2, 236/2);
    
    if (IS_IPHONE_5) {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
//            paletasBtn.frame = CGRectMake(125, 380*h/568, 152/2, 236/2);
            
            paletasBtn.frame = CGRectMake(110, 350*h/568, 220/2, 385/2);
            
        }
        else
        {
            //paletasBtn.frame = CGRectMake(125, (380*h/568)+20, 152/2, 236/2);
            
            //paletasBtn.frame = CGRectMake(125, (380*h/568)+20, 220/2, 385/2);
            
            paletasBtn.frame = CGRectMake(110, (350*h/568)+20, 220/2, 385/2);
            
        }

        
    }
    else
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
            paletasBtn.frame = CGRectMake(122.5, 332, 152/2, 236/2);
            
        }
        else
        {
            paletasBtn.frame = CGRectMake(122.5, 332+20, 152/2, 236/2);
            
        }
        
    }
    
    if(mainDelegate.selectedImageFromTagPage != nil)
    {
        
        tagEdited = TRUE;
        
        if(addedTagsArray == nil)
        {
            addedTagsArray = [[NSMutableArray alloc] init];
        }
        
        //menuPageBgSelectediPad.png
        if(IS_IPHONE_5)
        {
            background.image = [UIImage imageNamed:@"Menu_5WithTitle.png"];
        }
        else
        {
            //Menu1_4.png
            background.image = [UIImage imageNamed:@"Menu_4WithTitle.png"];
        }
        [self.view bringSubviewToFront:background];

        
        //Menu 1 Buttons Disabled
        newBtn.hidden = YES;
        newBtn.enabled = NO;
        
        paletasBtn.hidden = YES;
        paletasBtn.enabled = NO;
        
        shareBtn.hidden = YES;
        shareBtn.enabled = NO;
        
        //Menu 2 Buttons Enabled
        trashBtn.hidden = NO;
        trashBtn.enabled = YES;
        [self.view bringSubviewToFront:trashBtn];
        
        lastBtn.hidden = NO;
        lastBtn.enabled = YES;
        [self.view bringSubviewToFront:lastBtn];
        
        copyBtn.hidden = NO;
        copyBtn.enabled = YES;
        [self.view bringSubviewToFront:copyBtn];
        
        flipBtn.hidden = NO;
        flipBtn.enabled = YES;
        [self.view bringSubviewToFront:flipBtn];
        
        doneBtn.hidden = NO;
        doneBtn.enabled = YES;
        [self.view bringSubviewToFront:doneBtn];
        
//        float viewX = (4000-671)/2;
//        float viewY = (4080-663)/2;
        
//        MyUIImageView *gestureView = [[MyUIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
//        gestureView.tag = tagVar + 2000;
//        gestureView.frame = CGRectMake(-viewX, -viewY, 4000, 4080);
//        gestureView.backgroundColor = [UIColor clearColor];
//        gestureView.exclusiveTouch = YES;
//        gestureView.userInteractionEnabled = YES;
//        gestureView.opaque = NO;
        
//        float imgX = gestureView.frame.size.width/2 - 280/2;
//        float imgY = gestureView.frame.size.height/2 - 300/2;
        
        float tagImageWidth = mainDelegate.selectedImageFromTagPage.size.width;
        float tagImageHeight = mainDelegate.selectedImageFromTagPage.size.height;
        
        float tempVar = 130;
        
        while(1)
        {
            tagImageWidth = tempVar;//tagImageWidth/2;
            tagImageHeight = tempVar*mainDelegate.selectedImageFromTagPage.size.height/mainDelegate.selectedImageFromTagPage.size.width;//tagImageHeight/2;
            
            DLog(@"tagImageWidth : %f tagImageHeight : %f",tagImageWidth, tagImageHeight);
            
            if(tagImageHeight < 300)
            {
                break;
            }
            else
            {
                tempVar = tempVar - 10;
                continue;
            }
        }
        
        DLog(@"%@", mainDelegate.selectedImageFromTagPage.accessibilityIdentifier);
        
//        UIImageView *imageView = [[UIImageView alloc] init];
////        imageView.frame = CGRectMake(imgX, imgY, 280, 300);
//        imageView.frame = CGRectMake(0, 0, 280, 300);
//        imageView.center = [selectedImageView center];
//        //imageView.tag = tagVar;
//        imageView.backgroundColor = [UIColor clearColor];
//        imageView.userInteractionEnabled = YES;
//        imageView.layer.borderColor = [[UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:214.0/255.0 alpha:1.0] CGColor];
//        imageView.layer.borderWidth = 2.0;
//        [imageView setAccessibilityIdentifier:mainDelegate.selectedImageFromTagPage.accessibilityIdentifier];
//        imageView.opaque = NO;
//        [selectedImageView addSubview:imageView];
        
//        float imgXX = imageView.frame.size.width/2 - tagImageWidth/2;
//        float imgYY = imageView.frame.size.height/2 - tagImageHeight/2;
        
        
        float imgXX = selectedImageView.frame.size.width/2 - tagImageWidth/2;
        float imgYY = selectedImageView.frame.size.height/2 - tagImageHeight/2;
        
        UIImageView *originalImage = [[UIImageView alloc] initWithImage:mainDelegate.selectedImageFromTagPage];
        originalImage.backgroundColor = [UIColor clearColor];
        originalImage.layer.backgroundColor = [UIColor clearColor].CGColor;
        originalImage.tag = tagVar;
//        originalImage.frame = CGRectMake(imgXX, imgYY, tagImageWidth, tagImageHeight);
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
            originalImage.frame = CGRectMake(imgXX, imgYY, tagImageWidth, tagImageHeight);
            
        }
        else
        {
            originalImage.frame = CGRectMake(imgXX, imgYY+20, tagImageWidth, tagImageHeight);
            
        }
        
//        originalImage.center = [selectedImageView center];
        originalImage.userInteractionEnabled = YES;
        [originalImage setAccessibilityIdentifier:mainDelegate.selectedImageFromTagPage.accessibilityIdentifier];
        originalImage.layer.borderColor = [[UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:214.0/255.0 alpha:1.0] CGColor];
        originalImage.layer.borderWidth = 2.0;
        [selectedImageView addSubview:originalImage];
        
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
//        tapGesture.delegate = self;
//        [tapGesture addTarget:self action:@selector(imageTapped:)];
//        [originalImage addGestureRecognizer:tapGesture];
        
        DLog(@" imageView : %f %f" , originalImage.center.x, originalImage.center.x);
        
        DLog(@"originalImage : %f %f" , originalImage.center.x, originalImage.center.x);
        
        tagVar++;
        
        selectedTag = originalImage;
        [selectedTag setAccessibilityIdentifier:originalImage.accessibilityIdentifier];
        
        [addedTagsArray addObject:originalImage];
        
        DLog(@"%@", selectedTag.accessibilityIdentifier);
        
        mainDelegate.selectedImageFromTagPage = nil;
        
        [self.view bringSubviewToFront:clearBtn];
        
//        [selectedImageView bringSubviewToFront:gestureView];
        
        mainDelegate.gestureFlag = TRUE;
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"buttonClickSound" ofType:@"mp3"];
    buttonClickSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    buttonClickSound.volume = 6.0;
    buttonClickSound.delegate = self;
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"menuPageSound" ofType:@"mp3"];
    menuPageSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path1] error:NULL];
    menuPageSound.volume = 6.0;
    menuPageSound.delegate = self;
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"iceCreamManBtnSound" ofType:@"mp3"];
    iceCreamManBtnSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path2] error:NULL];
    iceCreamManBtnSound.volume = 6.0;
    iceCreamManBtnSound.delegate = self;
    
    self.view.userInteractionEnabled = YES;
    
    tagVar = 1001;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    w = mainDelegate.window.frame.size.width;
    h = mainDelegate.window.frame.size.height;
    
    if(IS_IPHONE_5)
    {
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Menu1_5.png"]];
    }
    else
    {
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Menu1_4.png"]];
    }
    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        
        background.frame = CGRectMake(0, -20, w, h);
        
    }
    else
    {
        background.frame = CGRectMake(0, 0, w, h);
        
    }
    
    background.backgroundColor = [UIColor clearColor];
    [self.view addSubview:background];
    
    //Menu 2 Buttons Disabled
    
    float menu2BtnX = 10;
    
    UIImage *trashBtnImage = [UIImage imageNamed:@"menuTrashBtn_iPhone5.png"];
    
    trashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        
        trashBtn.frame = CGRectMake(menu2BtnX, 450*h/568, trashBtnImage.size.width/2, trashBtnImage.size.height/2);
        
    }
    else
    {
        trashBtn.frame = CGRectMake(menu2BtnX, (450*h/568)+20, trashBtnImage.size.width/2, trashBtnImage.size.height/2);
        
    }
    
    [trashBtn setImage:trashBtnImage forState:UIControlStateNormal];
    [trashBtn addTarget:self action:@selector(trashBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    trashBtn.hidden = YES;
    trashBtn.enabled = NO;
    [self.view addSubview:trashBtn];
    
    UIImage *lastBtnImage = [UIImage imageNamed:@"menuLastBtn_iPhone5.png"];
    
    menu2BtnX = menu2BtnX + (trashBtnImage.size.width/2) + 8;
    
    lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        
        lastBtn.frame = CGRectMake(menu2BtnX, (450*h/568), lastBtnImage.size.width/2 , lastBtnImage.size.height/2);
        
    }
    else
    {
        lastBtn.frame = CGRectMake(menu2BtnX, (450*h/568) + 20, lastBtnImage.size.width/2 , lastBtnImage.size.height/2);
        
    }
    
    [lastBtn setImage:lastBtnImage forState:UIControlStateNormal];
    [lastBtn addTarget:self action:@selector(lastBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    lastBtn.hidden = YES;
    lastBtn.enabled = NO;
    [self.view addSubview:lastBtn];
    
    UIImage *copyBtnImage = [UIImage imageNamed:@"menuCopyBtn_iPhone5.png"];
    
    menu2BtnX = menu2BtnX + (lastBtnImage.size.width/2) + 8;
    
    copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        
        copyBtn.frame = CGRectMake(menu2BtnX, 450*h/568, copyBtnImage.size.width/2, copyBtnImage.size.height/2);
        
    }
    else
    {
        copyBtn.frame = CGRectMake(menu2BtnX, (450*h/568)+20, copyBtnImage.size.width/2, copyBtnImage.size.height/2);
        
    }

    
    [copyBtn setImage:copyBtnImage forState:UIControlStateNormal];
    [copyBtn addTarget:self action:@selector(copyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    copyBtn.hidden = YES;
    copyBtn.enabled = NO;
    [self.view addSubview:copyBtn];
    
    UIImage *flipBtnImage = [UIImage imageNamed:@"menuFlipBtn_iPhone5.png"];
    
    menu2BtnX = menu2BtnX + (copyBtnImage.size.width/2) + 8;
    
    flipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        
        flipBtn.frame = CGRectMake(menu2BtnX, 450*h/568, flipBtnImage.size.width/2, flipBtnImage.size.height/2);
        
    }
    else
    {
        flipBtn.frame = CGRectMake(menu2BtnX, (450*h/568) + 20, flipBtnImage.size.width/2, flipBtnImage.size.height/2);
        
    }
    
    [flipBtn setImage:flipBtnImage forState:UIControlStateNormal];
    [flipBtn addTarget:self action:@selector(flipBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    flipBtn.hidden = YES;
    flipBtn.enabled = NO;
    [self.view addSubview:flipBtn];
    
    UIImage *doneBtnImage = [UIImage imageNamed:@"menuDoneBtn_iPhone5.png"];
    
    menu2BtnX = menu2BtnX + (flipBtnImage.size.width/2) + 8;
    
    doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        
        doneBtn.frame = CGRectMake(menu2BtnX, 450*h/568, doneBtnImage.size.width/2, doneBtnImage.size.height/2);
        
    }
    else
    {
        doneBtn.frame = CGRectMake(menu2BtnX, (450*h/568)+20, doneBtnImage.size.width/2, doneBtnImage.size.height/2);
        
    }
    
    [doneBtn setImage:doneBtnImage forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    doneBtn.hidden = YES;
    doneBtn.enabled = NO;
    [self.view addSubview:doneBtn];
    
    UIImage *clearBtnImage = [UIImage imageNamed:@"clearBtn_iPhone5.png"];
    
    clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
//            clearBtn.frame = CGRectMake(225, 40*h/568, clearBtnImage.size.width/2, clearBtnImage.size.height/2);

            clearBtn.frame = CGRectMake(225, 25*h/568, clearBtnImage.size.width/2, clearBtnImage.size.height/2);
        }
        else
        {
            clearBtn.frame = CGRectMake(225, (40*h/568), clearBtnImage.size.width/2, clearBtnImage.size.height/2);
            
        }
        
    }
    else
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
            clearBtn.frame = CGRectMake(225, 0, clearBtnImage.size.width/2, clearBtnImage.size.height/2);
            
        }
        else
        {
            clearBtn.frame = CGRectMake(225, 20, clearBtnImage.size.width/2, clearBtnImage.size.height/2);
            
        }
        
        
    }
    [clearBtn setImage:clearBtnImage forState:UIControlStateNormal];
    clearBtn.backgroundColor = [UIColor clearColor];
    [clearBtn addTarget:self action:@selector(clearBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];
    
    //Menu 1 Buttons Enabled
    
    UIImage *newBtnImage = [UIImage imageNamed:@"newBtn_iPhone5.png"];
    
    newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
//            newBtn.frame = CGRectMake(0, 470*h/568, newBtnImage.size.width/2, newBtnImage.size.height/2);
            
            newBtn.frame = CGRectMake(7, 480*h/568, newBtnImage.size.width/2, newBtnImage.size.height/2);
            
        }
        else
        {
//            newBtn.frame = CGRectMake(0, (470*h/568)+20, newBtnImage.size.width/2, newBtnImage.size.height/2);
            newBtn.frame = CGRectMake(7, (480*h/568)+20, newBtnImage.size.width/2, newBtnImage.size.height/2);
            
        }
        
    }
    else
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
//            newBtn.frame = CGRectMake(0, 413, newBtnImage.size.width/2, newBtnImage.size.height/2);
            
            newBtn.frame = CGRectMake(7, 413, newBtnImage.size.width/2, newBtnImage.size.height/2);
            
        }
        else
        {
            newBtn.frame = CGRectMake(0, 413 + 20, newBtnImage.size.width/2, newBtnImage.size.height/2);
            
        }
        
    }
    [newBtn setImage:newBtnImage forState:UIControlStateNormal];
    newBtn.backgroundColor = [UIColor clearColor];
    [newBtn addTarget:self action:@selector(newBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newBtn];
    
    UIImage *shareBtnImage = [UIImage imageNamed:@"shareBtnOnMenuPage_iPhone5.png"];
    
    shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
//            shareBtn.frame = CGRectMake(225, 470*h/568, shareBtnImage.size.width/2, shareBtnImage.size.height/2);

            
            shareBtn.frame = CGRectMake(219, 480*h/568, shareBtnImage.size.width/2, shareBtnImage.size.height/2);
        }
        else
        {
//            shareBtn.frame = CGRectMake(225, (470*h/568)+20, shareBtnImage.size.width/2, shareBtnImage.size.height/2);
            
            shareBtn.frame = CGRectMake(219, (480*h/568)+20, shareBtnImage.size.width/2, shareBtnImage.size.height/2);
            
        }
        
    }
    else
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
//            shareBtn.frame = CGRectMake(227, 413, shareBtnImage.size.width/2, shareBtnImage.size.height/2);
            shareBtn.frame = CGRectMake(221, 413, shareBtnImage.size.width/2, shareBtnImage.size.height/2);
            
        }
        else
        {
            shareBtn.frame = CGRectMake(227, 413 + 20, shareBtnImage.size.width/2, shareBtnImage.size.height/2);
            
        }

        
    }
    [shareBtn setImage:shareBtnImage forState:UIControlStateNormal];
    shareBtn.backgroundColor = [UIColor clearColor];
    [shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    float newWidth, newHeight;
    
    newWidth = 320;
    newHeight = menuSelectedImage.size.height * (newWidth/menuSelectedImage.size.width);
    
    selectedImageView = [[UIImageView alloc] init];
    if(IS_IPHONE_5)
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
            selectedImageView.frame = CGRectMake(0, 89*h/568, 320, 315*h/568);
            
        }
        else
        {
            selectedImageView.frame = CGRectMake(0, (109*h/568), 320, 315*h/568);
            
        }
        
    }
    else
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
            selectedImageView.frame = CGRectMake(0, 46, 320, 316);
            
        }
        else
        {
            selectedImageView.frame = CGRectMake(0, 66, 320, 316);
            
        }

        
    }
    selectedImageView.userInteractionEnabled = YES;
    selectedImageView.backgroundColor = [UIColor blackColor];
    selectedImageView.layer.backgroundColor = [UIColor clearColor].CGColor;
    [self.view addSubview:selectedImageView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
    panGesture.delegate = self;
    [selectedImageView addGestureRecognizer:panGesture];
    [panGesture addTarget:self action:@selector(dragging:)];
    
    UIPinchGestureRecognizer *mypinch = [ [UIPinchGestureRecognizer alloc] init];
    mypinch.delegate = self;
    [mypinch addTarget:self action:@selector(myevent:)];
    [selectedImageView addGestureRecognizer:mypinch];
    
    UIRotationGestureRecognizer *rotateGesture = [ [UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(MyRotationEvent:)];
    rotateGesture.delegate = self;
    [selectedImageView addGestureRecognizer:rotateGesture];
    
    float imgY;
    if(newHeight < 315)
    {
        imgY = (315 - newHeight) / 2;
    }
    else
    {
        imgY = 0;
        newHeight = 315;
    }
    
    UIImageView *centralImageView = [[UIImageView alloc] initWithImage:menuSelectedImage];
    centralImageView.tag = 100;
    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        
        centralImageView.frame = CGRectMake(0, imgY, newWidth, newHeight);
        
    }
    else
    {
        centralImageView.frame = CGRectMake(0, imgY, newWidth, newHeight+5);
        
    }
    
    centralImageView.backgroundColor = [UIColor clearColor];
    centralImageView.userInteractionEnabled = YES;
    centralImageView.layer.backgroundColor = [UIColor clearColor].CGColor;
    [selectedImageView addSubview:centralImageView];
    
    //paletasBtniPad.png paletasBtnSelectediPad.png closedMigoBtn_iPhone5.png openMigoBtn_iPhone5.png
    paletasBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IS_IPHONE_5) {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            NSLog(@"paletasBtn ios6");
//            paletasBtn.frame = CGRectMake(125, 380*h/568, 152/2, 236/2);
            
            paletasBtn.frame = CGRectMake(110, 350*h/568, 220/2, 385/2);
            
        }
        else
        {
//            paletasBtn.frame = CGRectMake(125, (380*h/568)+20, 152/2, 236/2);
            
            paletasBtn.frame = CGRectMake(110, (350*h/568)+20, 220/2, 385/2);
            
        }
        
    }
    else
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
//            paletasBtn.frame = CGRectMake(122.5, 332, 152/2, 236/2);
            
            paletasBtn.frame = CGRectMake(128, 332, 152/2, 236/2);
            
        }
        else
        {
            paletasBtn.frame = CGRectMake(122.5, 332+20, 152/2, 236/2);
            
        }
        
    }
//    [paletasBtn setImage:[UIImage imageNamed:@"MigoBtnNormal_iPhone.png"] forState:UIControlStateNormal];
//    [paletasBtn setImage:[UIImage imageNamed:@"MigoBtnPressed_iPhone.png"] forState:UIControlStateSelected];
    
    [paletasBtn setImage:[UIImage imageNamed:@"Migoman_n.png"] forState:UIControlStateNormal];
    [paletasBtn setImage:[UIImage imageNamed:@"Migoman_p.png"] forState:UIControlStateSelected];
    paletasBtn.backgroundColor = [UIColor clearColor];
    [paletasBtn addTarget:self action:@selector(paletasBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:paletasBtn];
    
    [menuPageSound play];
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    lastBtnFlag = FALSE;
    
    [super touchesBegan:touches withEvent:event];
    
//    UITouch *touch = [touches anyObject];
//    
//    if ([touch tapCount] == 1) {
//        
//        mainDelegate.singleTapFlag = TRUE;
//        
//        mainDelegate.newFlag = TRUE;
//        
//        CGPoint point = [touch locationInView:self.view];
//        
//        CGPoint pointInSubview = [touch.view convertPoint:point fromView:touch.view.superview];
//        
//        [touch.view pointInside:pointInSubview withEvent:event];
//        
//        mainDelegate.newFlag = FALSE;
//        
//    }
//    else if([touch tapCount] == 2)
//    {
//        
//    }
//    
//    if(mainDelegate.isUserInterActionEnabled)
//    {
//        DLog(@"Transparent touches enabled");
//    }
//    else
//    {
//        DLog(@"Transparent touches disabled");
//    }
//    
    
    UITouch *touch = [touches anyObject];
    
    UIView *touchedView = [touch view];
    
    DLog(@"%d",touchedView.tag);
    DLog(@"%d",tagEdited);
    
    //UITouch *touch = [touches anyObject];
    
//    if ([touch tapCount] == 1) {
//        
//        mainDelegate.singleTapFlag = TRUE;
//        
//    }
//    else if([touch tapCount] == 2)
//    {
//        
//    }
    
    if(touchedView.tag > 1000 && [touchedView isKindOfClass:[UIImageView class]])
    {
        
        tagEdited = TRUE;
        if(selectedTag != nil)
        {
            selectedTag.layer.borderWidth = 0.0;
            selectedTag.layer.borderColor = [[UIColor clearColor] CGColor];
        }
        
        DLog(@"%@",touchedView.accessibilityIdentifier);
        
        UIImageView *touchedImage = (UIImageView *)touchedView;
        [touchedImage setAccessibilityIdentifier:touchedView.accessibilityIdentifier];
        touchedImage.layer.borderColor = [[UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:214.0/255.0 alpha:1.0] CGColor];
        touchedImage.layer.borderWidth = 2.0;
        selectedTag = touchedImage;
        [selectedTag setAccessibilityIdentifier:touchedImage.accessibilityIdentifier];
        
//        [touchedImage becomeFirstResponder];
//        touchedImage.superview.userInteractionEnabled = YES;
        
        mainDelegate.gestureFlag = TRUE;
        
        DLog(@"%@",selectedTag.accessibilityIdentifier);
        
        //menuPageBgSelectediPad.png
        if(IS_IPHONE_5)
        {
            background.image = [UIImage imageNamed:@"Menu_5WithTitle.png"];
        }
        else
        {
            //Menu1_4.png
            background.image = [UIImage imageNamed:@"Menu_4WithTitle.png"];
        }
        
        //Menu 1 Buttons Disabled
        newBtn.hidden = YES;
        newBtn.enabled = NO;
        
        paletasBtn.hidden = YES;
        paletasBtn.enabled = NO;
        
        shareBtn.hidden = YES;
        shareBtn.enabled = NO;
        
        //Menu 2 Buttons Enabled
        trashBtn.hidden = NO;
        trashBtn.enabled = YES;
        [self.view bringSubviewToFront:trashBtn];
        
        lastBtn.hidden = NO;
        lastBtn.enabled = YES;
        [self.view bringSubviewToFront:lastBtn];
        
        copyBtn.hidden = NO;
        copyBtn.enabled = YES;
        [self.view bringSubviewToFront:copyBtn];
        
        flipBtn.hidden = NO;
        flipBtn.enabled = YES;
        [self.view bringSubviewToFront:flipBtn];
        
        doneBtn.hidden = NO;
        doneBtn.enabled = YES;
        [self.view bringSubviewToFront:doneBtn];
        
        [selectedImageView bringSubviewToFront:selectedTag];
        
    }
   
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
//    UITouch *touch = [touches anyObject];
//    
//    if ([touch tapCount] == 1) {
//       
//        mainDelegate.singleTapFlag = TRUE;
//        
//        mainDelegate.newFlag = TRUE;
//        
//        CGPoint point = [touch locationInView:self.view];
//        
//        CGPoint pointInSubview = [touch.view convertPoint:point fromView:touch.view.superview];
//        
//        [touch.view pointInside:pointInSubview withEvent:event];
//        
//        mainDelegate.newFlag = FALSE;
//        
//    }
//    else if([touch tapCount] == 2)
//    {
//        
//    }
//    
//    if(mainDelegate.isUserInterActionEnabled)
//    {
//        DLog(@"Transparent touches enabled");
//    }
//    else
//    {
//        DLog(@"Transparent touches disabled");
//    }
    
    
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

#pragma mark - Button Action Methods

-(IBAction)trashBtnAction:(id)sender
{
    
    [buttonClickSound play];
    
    if(IS_IPHONE_5)
    {
        background.image = [UIImage imageNamed:@"Menu1_5.png"];
    }
    else
    {
        background.image = [UIImage imageNamed:@"Menu1_4.png"];
    }
    
    selectedTag.layer.borderWidth = 0.0;
    selectedTag.layer.borderColor = [[UIColor clearColor] CGColor];
    
    [selectedTag removeFromSuperview];
    
    selectedTag = nil;
    
    //Menu 2 Buttons Disabled
    trashBtn.hidden = YES;
    trashBtn.enabled = NO;
    
    lastBtn.hidden = YES;
    lastBtn.enabled = NO;
    
    copyBtn.hidden = YES;
    copyBtn.enabled = NO;
    
    flipBtn.hidden = YES;
    flipBtn.enabled = NO;
    
    doneBtn.hidden = YES;
    doneBtn.enabled = NO;
    
    //Menu 1 Buttons Enabled
    newBtn.hidden = NO;
    newBtn.enabled = YES;
    [self.view bringSubviewToFront:newBtn];
    
    paletasBtn.hidden = NO;
    paletasBtn.enabled = YES;
    [self.view bringSubviewToFront:paletasBtn];
    
    shareBtn.hidden = NO;
    shareBtn.enabled = YES;
    [self.view bringSubviewToFront:shareBtn];
    
    tagEdited = FALSE;

}

-(IBAction)lastBtnAction:(id)sender
{
    [buttonClickSound play];
    
    if(!lastBtnFlag)
    {
        
        NSArray *subviewArray = [selectedImageView subviews];
        
        DLog(@"subviewArray");
        
        for(int i = [subviewArray count]-2 ; i >= 0 ; i--)
        {
            UIImageView *secondLastImageView = (UIImageView *)[subviewArray objectAtIndex:i];
            
            if(selectedImageView.tag != selectedTag.tag)
            {
                if(CGRectContainsPoint(selectedTag.frame, [secondLastImageView center]) && secondLastImageView.tag != 100)
                {
                    
                    [selectedImageView bringSubviewToFront:secondLastImageView];
                    lastBtnFlag = TRUE;
                    break;

                }
            }
            
        }
    }
    
    
//    selectedTag.layer.borderWidth = 0.0;
//    selectedTag.layer.borderColor = [[UIColor clearColor] CGColor];
//    
//    UIImageView *tempImageView = (UIImageView *)[addedTagsArray objectAtIndex:[addedTagsArray count] - 1];
//    
//    selectedTag = tempImageView;
//    [selectedTag setAccessibilityIdentifier:tempImageView.accessibilityIdentifier];
//    selectedTag.layer.borderColor = [[UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:214.0/255.0 alpha:1.0] CGColor];
//    selectedTag.layer.borderWidth = 2.0;
}

-(IBAction)copyBtnAction:(id)sender
{
    
    UIImage *lastAddedTag = selectedTag.image;
    
    if(lastAddedTag == nil)
    {
        if(selectedTag != nil)
        {
            NSArray *subviewsArray = [selectedTag subviews];
            
            for(UIView *view in subviewsArray)
            {
                if([view isKindOfClass:[UIImageView class]])
                {
                    UIImageView *temp = (UIImageView *)view;
                    lastAddedTag = temp.image;
                    break;
                }
            }
        }
    }
    
    if(lastAddedTag != nil)
    {
        
        [buttonClickSound play];
        
        selectedTag.layer.borderWidth = 0.0;
        selectedTag.layer.borderColor = [[UIColor clearColor] CGColor];
        
//        float viewX = (4000-671)/2;
//        float viewY = (4080-663)/2;
//        
//        MyUIImageView *gestureView1 = [[MyUIImageView alloc] init];
//        gestureView1.frame = CGRectMake(-viewX, -viewY, 4000, 4080);
//        gestureView1.backgroundColor = [UIColor clearColor];
//        gestureView1.userInteractionEnabled = YES;
//        [selectedImageView addSubview:gestureView1];
//        
//        UIPinchGestureRecognizer *mypinch = [ [UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(myevent:) ];
//        mypinch.delegate = self;
//        [gestureView1 addGestureRecognizer:mypinch];
//        
//        UIRotationGestureRecognizer *rotateGesture = [ [UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(MyRotationEvent:)];
//        rotateGesture.delegate = self;
//        [gestureView1 addGestureRecognizer:rotateGesture];
//        
//        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
//        panGesture.delegate = self;
//        [gestureView1 addGestureRecognizer:panGesture];
//        
//        
//
//        float imgX = gestureView1.frame.size.width/2 - 280/2;
//        float imgY = gestureView1.frame.size.height/2 - 300/2;
        
    //    float imgX = gestureView.frame.size.width/2 - 167/2;
    //    float imgY = gestureView.frame.size.height/2 - 175/2;
        
        float tagImageWidth = lastAddedTag.size.width;
        float tagImageHeight = lastAddedTag.size.height;
        
        float tempVar = 130;
        
        DLog(@"lastAddedTag.size.width : %f lastAddedTag.size.height : %f",lastAddedTag.size.width, lastAddedTag.size.height);
        
        while(1)
        {
            tagImageWidth = tempVar;//tagImageWidth/2;
            tagImageHeight = tempVar*lastAddedTag.size.height/lastAddedTag.size.width;//tagImageHeight/2;
            
            DLog(@"tagImageWidth : %f tagImageHeight : %f",tagImageWidth, tagImageHeight);
            
            if(tagImageHeight < 300)
            {
                break;
            }
            else
            {
                tempVar = tempVar - 10;
                continue;
            }
        }
        
        DLog(@"%@", lastAddedTag.accessibilityIdentifier);
        
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.frame = CGRectMake(0, 0, 280, 300);
//        imageView.center = [selectedImageView center];
//        imageView.tag = tagVar;
//        imageView.backgroundColor = [UIColor clearColor];
//        imageView.userInteractionEnabled = YES;
//        imageView.layer.borderColor = [[UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:214.0/255.0 alpha:1.0] CGColor];
//        imageView.layer.borderWidth = 2.0;
//        [selectedImageView addSubview:imageView];
//        
//        float imgXX = imageView.frame.size.width/2 - tagImageWidth/2;
//        float imgYY = imageView.frame.size.height/2 - tagImageHeight/2;
        
        float imgXX = selectedImageView.frame.size.width/2 - tagImageWidth/2;
        float imgYY = selectedImageView.frame.size.height/2 - tagImageHeight/2;
        
        UIImageView *originalImage = [[UIImageView alloc] initWithImage:lastAddedTag];
        originalImage.backgroundColor = [UIColor clearColor];
        originalImage.tag = tagVar;
        originalImage.frame = CGRectMake(imgXX, imgYY, tagImageWidth, tagImageHeight);
        originalImage.userInteractionEnabled = YES;
//        originalImage.center = [selectedImageView center];
        [originalImage setAccessibilityIdentifier:lastAddedTag.accessibilityIdentifier];
        originalImage.layer.borderColor = [[UIColor colorWithRed:255.0/255.0 green:56.0/255.0 blue:214.0/255.0 alpha:1.0] CGColor];
        originalImage.layer.borderWidth = 2.0;
        [selectedImageView addSubview:originalImage];
        
        tagVar++;
        
        selectedTag = originalImage;
        [selectedTag setAccessibilityIdentifier:originalImage.accessibilityIdentifier];
        
        [addedTagsArray addObject:originalImage];
        
        lastAddedTag = nil;
        
    }
}

-(IBAction)flipBtnAction:(id)sender
{
    
    [buttonClickSound play];
    
    NSString *file_name = [selectedTag accessibilityIdentifier] ;
    
    NSArray *subviewsArray = [selectedTag subviews];
    
    DLog(@"%@", subviewsArray);
    
    UIImageView *addedImageView = nil;
    
    if([subviewsArray count] >= 1)
    {
        for(UIView *view in subviewsArray)
        {
            if([view isKindOfClass:[UIImageView class]])
            {
                addedImageView = (UIImageView *)view;
                break;
            }
        }
    }
    else
    {
        addedImageView = selectedTag;
    }
    
     DLog(@"%@", addedImageView);
    
//    UIImageView *addedImageView = (UIImageView*)[selectedTag viewWithTag:100];
    
    DLog(@"%@", file_name);
    
    NSString *digits = [file_name stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    DLog(@"Message id: %d", [digits intValue]);
    
    if([file_name rangeOfString:@"FlippedSticker"].location != NSNotFound)
    {
//        addedImageView.image = nil;
        //selectedTag.image = [UIImage imageNamed:file_name];
        [addedImageView setImage:[UIImage imageNamed:file_name]];
        [addedImageView setNeedsDisplay];
        [selectedTag setAccessibilityIdentifier:[NSString stringWithFormat:@"OriginalSticker%d.png", [digits intValue]]];
        [addedImageView setAccessibilityIdentifier:[NSString stringWithFormat:@"OriginalSticker%d.png", [digits intValue]]];
        
    }
    else if([file_name rangeOfString:@"OriginalSticker"].location != NSNotFound)
    {
//        addedImageView.image = nil;
//        selectedTag.image = [UIImage imageNamed:file_name];
        [addedImageView setImage:[UIImage imageNamed:file_name]];
        [addedImageView setNeedsDisplay];
        [selectedTag setAccessibilityIdentifier:[NSString stringWithFormat:@"FlippedSticker%d.png", [digits intValue]]];
        [addedImageView setAccessibilityIdentifier:[NSString stringWithFormat:@"FlippedSticker%d.png", [digits intValue]]];
    }
    
}

-(IBAction)doneBtnAction:(id)sender
{
    
    mainDelegate.gestureFlag = FALSE;
    
    [buttonClickSound play];
    
    if(IS_IPHONE_5)
    {
        background.image = [UIImage imageNamed:@"Menu1_5.png"];
    }
    else
    {
        background.image = [UIImage imageNamed:@"Menu1_4.png"];
    }
    
    selectedTag.layer.borderWidth = 0.0;
    selectedTag.layer.borderColor = [[UIColor clearColor] CGColor];
        
    selectedTag = nil;
    
    //Menu 2 Buttons Disabled 
    trashBtn.hidden = YES;
    trashBtn.enabled = NO;
    
    lastBtn.hidden = YES;
    lastBtn.enabled = NO;
    
    copyBtn.hidden = YES;
    copyBtn.enabled = NO;
    
    flipBtn.hidden = YES;
    flipBtn.enabled = NO;
    
    doneBtn.hidden = YES;
    doneBtn.enabled = NO;

    //Menu 1 Buttons Enabled
    newBtn.hidden = NO;
    newBtn.enabled = YES;
    [self.view bringSubviewToFront:newBtn];
    
    paletasBtn.hidden = NO;
    paletasBtn.enabled = YES;
    [self.view bringSubviewToFront:paletasBtn];
    
    shareBtn.hidden = NO;
    shareBtn.enabled = YES;
    [self.view bringSubviewToFront:shareBtn];
    
    tagEdited = FALSE;
        
}

-(IBAction)clearBtnAction:(id)sender
{
    
    [buttonClickSound play];
    
    UIAlertView *clearAlert = [[[UIAlertView alloc] initWithTitle:@"Clear All?" message:@"Remove all stickers from background?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] autorelease];
    clearAlert.tag = 200;
    [clearAlert show];
}

-(IBAction)newBtnAction:(id)sender
{
    
    [buttonClickSound play];
    
    UIAlertView *newAlert = [[[UIAlertView alloc] initWithTitle:@"Start Over?" message:@"Ready to take a new photo?" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:@"Yes", nil] autorelease];
    newAlert.tag = 100;
    [newAlert show];
}

-(IBAction)shareBtnAction:(id)sender
{
    
    [buttonClickSound play];
    
    UIImage *image;
    
    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        image = [UIImage imageWithView:selectedImageView];
    }
    else
    {
        //        UIView *view = [selectedImageView snapshotViewAfterScreenUpdates:NO];//[selectedImageView resizableSnapshotViewFromRect:CGRectMake(0, 0, 100, 100) afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];//[selectedImageView snapshotViewAfterScreenUpdates:YES];
        //
        //        // Convert to UIImage
        //        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
        //        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        //        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        //        UIGraphicsEndImageContext();
        
        //        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
        //
        //        [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
        //
        //        UIImage *image1 = UIGraphicsGetImageFromCurrentImageContext();
        //        UIGraphicsEndImageContext();
        
        
        UIGraphicsBeginImageContextWithOptions(selectedImageView.bounds.size, NO, [UIScreen mainScreen].scale);
        
        [selectedImageView drawViewHierarchyInRect:selectedImageView.bounds afterScreenUpdates:YES];
        
        UIImage *image1 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        image = image1;
        
    }
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"Saving...";
  
    [self performSelector:@selector(showSharePage:) withObject:image afterDelay:1.0];
}

-(void)showSharePage : (UIImage *)imageToBeSaved
{
    
    
    
    UIImage *backgroundImage = [self screenshot];
    
    mainDelegate.sharePageObj = [[SharePage_iPad alloc] init];
    mainDelegate.sharePageObj.finalImage = imageToBeSaved;
    mainDelegate.sharePageObj.backImage = backgroundImage;
    [self presentModalViewController:mainDelegate.sharePageObj animated:NO];
    //[self.view addSubview:mainDelegate.sharePageObj.view];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.hud = nil;
}

-(UIImage *) screenshot
{
    
    CGRect rect;
    rect=CGRectMake(0, 0, w, h);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(IBAction)paletasBtnAction:(id)sender
{
    
    if(!mainDelegate.migoBtnFlag)
    {
        mainDelegate.migoBtnFlag = TRUE;
    
        [iceCreamManBtnSound play];
    }
    
    UIButton *btn = (UIButton *)sender;

    btn.selected = YES;
    
    
    //paletasBtn.frame = CGRectMake(125, 380, 161/2, 245/2);
    
//    if (IS_IPHONE_5) {
//        paletasBtn.frame = CGRectMake(125, 380*h/568, 161/2, 245/2);
//    }
//    else
//    {
//        paletasBtn.frame = CGRectMake(122.5, 332, 152/2, 236/2);
//    }
    
    [self performSelector:@selector(showTagsPage) withObject:nil afterDelay:0.08];
   
}

-(void)showTagsPage
{
    TagsPage_iPad *tagsPageObj = [[TagsPage_iPad alloc] init];
    [self presentModalViewController:tagsPageObj animated:YES];
}

#pragma mark - UIGestureRecognizer Delegate Methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
        return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
{
    
    return YES;
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if([gestureRecognizer class] == [UIRotationGestureRecognizer class] || [gestureRecognizer class] == [UIPanGestureRecognizer class] || [gestureRecognizer class] == [UIPinchGestureRecognizer class])
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

#pragma mark - UIPanGestureRecognizer Method

- (void) imageTapped: (UIPanGestureRecognizer*) sender
{
    
    DLog(@"Image Tapped");
    
    UITapGestureRecognizer *gestureRecognizer = (UITapGestureRecognizer *) sender;
    
    [selectedImageView bringSubviewToFront:gestureRecognizer.view.superview];
    
}

#pragma mark - UIPanGestureRecognizer Method

- (void) dragging: (UIPanGestureRecognizer*) p
{
    
    [selectedImageView bringSubviewToFront:selectedTag];
    
    CGPoint translation = [p translationInView:selectedImageView];
    [p setTranslation:CGPointMake(0, 0) inView:selectedImageView];
    
    CGPoint center = selectedTag.center;
    center.y += translation.y;
    center.x += translation.x;
    
    DLog(@"%f", center.x);
    
    selectedTag.center = center;
   
}

#pragma mark - UIRotationGestureRecognizer Method

-(void)MyRotationEvent:(UIRotationGestureRecognizer *)sender
{
    
    [selectedImageView bringSubviewToFront:selectedTag];
    
    UIRotationGestureRecognizer *gestureRecogniser = (UIRotationGestureRecognizer *) sender;
    selectedTag.transform = CGAffineTransformRotate(selectedTag.transform, gestureRecogniser.rotation);
    gestureRecogniser.rotation = 0;
    
}

#pragma mark - UIPinchGestureRecognizer Method

-(void)myevent:(UIPinchGestureRecognizer *)sender
{
    
    [selectedImageView bringSubviewToFront:selectedTag];
    
    UIPinchGestureRecognizer *gestureRecognizer = (UIPinchGestureRecognizer *) sender;
    
    if([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        // Reset the last scale, necessary if there are multiple objects with different scales
        lastScale = [gestureRecognizer scale];
    }
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan ||
        [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[selectedTag.layer valueForKeyPath:@"transform.scale"] floatValue];
        
        // Constants to adjust the max/min values of zoom
        const CGFloat kMaxScale = 2.0;
        const CGFloat kMinScale = 0.5;
        
        CGFloat newScale = 1 -  (lastScale - [gestureRecognizer scale]); // new scale is in the range (0-1)
        newScale = MIN(newScale, kMaxScale / currentScale);
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale([selectedTag transform], newScale, newScale);
        selectedTag.transform = transform;
        
//        selectedTag.layer.backgroundColor = [UIColor clearColor].CGColor;
        
        
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        
//        CGContextBeginTransparencyLayer(context, NULL);
//        
//        CGContextDrawImage(context, selectedTag.frame, selectedTag.image.CGImage);
//        // Draw blend on top of image
//        CGContextClipToMask(context, selectedTag.frame, selectedTag.image.CGImage);
//        CGContextSetBlendMode(context, kCGBlendModeColor);
//        CGContextFillRect(context, selectedTag.frame);
//        
//        CGContextEndTransparencyLayer(context);
        
        
        
        lastScale = [gestureRecognizer scale];  // Store the previous scale factor for the next pinch gesture call
    }
    
}

#pragma mark - UIAlerView Delegate Mathods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [buttonClickSound play];
    
    if(alertView.tag == 100)
    {
        if (buttonIndex == 0){
            DLog(@"No Thanks clicked");
            //cancel clicked ...do your action
        }else if (buttonIndex == 1){
             DLog(@"Yes clicked");
            
            [self dismissModalViewControllerAnimated:NO];
            //reset clicked
        }
    }
    
    if(alertView.tag == 200)
    {
        if (buttonIndex == 0){
            DLog(@"No");
            //cancel clicked ...do your action
        }else if (buttonIndex == 1){
            DLog(@"Yes clicked");
            
            for(int i = 0; i< [addedTagsArray count]; i++)
            {
                if([[addedTagsArray objectAtIndex:i] isKindOfClass:[UIImageView class]])
                {
                    [[addedTagsArray objectAtIndex:i] removeFromSuperview];
                }
            }
            
            if(IS_IPHONE_5)
            {
                background.image = [UIImage imageNamed:@"Menu1_5.png"];
            }
            else
            {
                background.image = [UIImage imageNamed:@"Menu1_4.png"];
            }
            
            selectedTag = nil;
            
            //Menu 2 Buttons Disabled
            trashBtn.hidden = YES;
            trashBtn.enabled = NO;
            
            lastBtn.hidden = YES;
            lastBtn.enabled = NO;
            
            copyBtn.hidden = YES;
            copyBtn.enabled = NO;
            
            flipBtn.hidden = YES;
            flipBtn.enabled = NO;
            
            doneBtn.hidden = YES;
            doneBtn.enabled = NO;
            
            //Menu 1 Buttons Enabled
            newBtn.hidden = NO;
            newBtn.enabled = YES;
            [self.view bringSubviewToFront:newBtn];
            
            paletasBtn.hidden = NO;
            paletasBtn.enabled = YES;
            [self.view bringSubviewToFront:paletasBtn];
            
            shareBtn.hidden = NO;
            shareBtn.enabled = YES;
            [self.view bringSubviewToFront:shareBtn];
            
            tagEdited = FALSE;

            
            //reset clicked
        }
    }
}

#pragma mark - UIInterfaceOrientation Methods

- (BOOL)shouldAutorotate  // iOS 6 autorotation fix
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations // iOS 6 autorotation fix
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        return YES;
    }
    
    else
        return NO;
}

#pragma mark - Memory Management Mathods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
