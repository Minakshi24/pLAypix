//
//  FirstPage_iPad.m
//  Snoopify
//
//  Created by Minakshi on 6/26/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "FirstPage_iPad.h"
#import "MenuPage_iPad.h"
#import "common.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface FirstPage_iPad ()

@end

@implementation FirstPage_iPad

@synthesize selectedImage;

#pragma mark - UIViewController Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    w = mainDelegate.window.frame.size.width;
    h = mainDelegate.window.frame.size.height;
   
    NSString *path = [[NSBundle mainBundle] pathForResource:@"buttonClickSound" ofType:@"mp3"];
    buttonClickSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    buttonClickSound.volume = 6.0;
    buttonClickSound.delegate = self;
    
    
    self.view.backgroundColor = [UIColor blackColor];
    
    //firstPageBg_iPhone5.png
    //firstPageRef_iPhone5.png
    UIImageView *background = nil;
    
    if(IS_IPHONE_5)
    {
        //FirstMenuPage_5_1
//        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"firstPageBg_iPhone5.png"]];
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FirstMenuPage_5_1.png"]];
        
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
        
            NSLog(@"iOS6");
            background.frame = CGRectMake(0, -20, 320, h);
            
        }
        else
        {
            background.frame = CGRectMake(0, 0, 320, h);
            
        }
    }
    else
    {
        
        //firstPageBg_iPhone4.png
        
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"firstPageBg_iPhone4.png"]];
        
        
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
            background.frame = CGRectMake(0, -20, 320, h);
            
        }
        else
        {
            background.frame = CGRectMake(0, 0, 320, h);
            
        }
        
    }
    
    background.backgroundColor = [UIColor clearColor];
    [self.view addSubview:background];
    [background release];
    
    UIImage *twitterBtnImage = [UIImage imageNamed:@"twitterBtn_iPhone5.png"];
    
    UIButton *tweeterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
    { 
        
        tweeterBtn.frame = CGRectMake(5, 5, twitterBtnImage.size.width/2, twitterBtnImage.size.height/2);
        
    }
    else
    {
        tweeterBtn.frame = CGRectMake(5, 25, twitterBtnImage.size.width/2, twitterBtnImage.size.height/2);
        
    }
    
    [tweeterBtn setImage:twitterBtnImage forState:UIControlStateNormal];
    tweeterBtn.backgroundColor = [UIColor clearColor];
    [tweeterBtn addTarget:self action:@selector(tweeterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tweeterBtn];
    tweeterBtn = nil;
    
    UIImage *instagramBtnImage = [UIImage imageNamed:@"instagramBtn_iPhone5.png"];
    
    UIButton *instagramBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        
        instagramBtn.frame = CGRectMake(50, 5, instagramBtnImage.size.width/2, instagramBtnImage.size.height/2);
        
    }
    else
    {
        instagramBtn.frame = CGRectMake(50, 25, instagramBtnImage.size.width/2, instagramBtnImage.size.height/2);
        
    }
    
    [instagramBtn setImage:instagramBtnImage forState:UIControlStateNormal];
    instagramBtn.backgroundColor = [UIColor clearColor];
    [instagramBtn addTarget:self action:@selector(instagramBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:instagramBtn];
    
    UIImage *shareBtnImage = [UIImage imageNamed:@"shareBtn_iPhone5.png"];
    
    NSLog(@"%f",(320.0-(shareBtnImage.size.width/2)));
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        
        shareBtn.frame = CGRectMake(225, 5, (shareBtnImage.size.width/2) + 15, (shareBtnImage.size.height/2) + 10);
        
    }
    else
    {
        shareBtn.frame = CGRectMake(225, 25, (shareBtnImage.size.width/2) + 15, (shareBtnImage.size.height/2) + 10);
        
    }
    
    
    [shareBtn setImage:shareBtnImage forState:UIControlStateNormal];
    shareBtn.backgroundColor = [UIColor clearColor];
    [shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    UIImage *takePhotoBtnImage = [UIImage imageNamed:@"takePhotoBtn_iPhone5.png"];
    
    UIButton *takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoBtn.frame = CGRectMake(5, 350*h/568, takePhotoBtnImage.size.width/2, takePhotoBtnImage.size.height/2);
    [takePhotoBtn setImage:takePhotoBtnImage forState:UIControlStateNormal];
    takePhotoBtn.backgroundColor = [UIColor clearColor];
    [takePhotoBtn addTarget:self action:@selector(takePhotoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takePhotoBtn];
    
    UIImage *myLibraryBtnImage = [UIImage imageNamed:@"myLibraryBtn_iPhone5.png"];
    
    UIButton *myLibraryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myLibraryBtn.frame = CGRectMake(160, 350*h/568, myLibraryBtnImage.size.width/2, myLibraryBtnImage.size.height/2);
    [myLibraryBtn setImage:myLibraryBtnImage forState:UIControlStateNormal];
    myLibraryBtn.backgroundColor = [UIColor clearColor];
    [myLibraryBtn addTarget:self action:@selector(myLibraryBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myLibraryBtn];
    
}

-(IBAction)tweeterBtnAction:(id)sender
{
    
    [buttonClickSound play];
    
    NSURL *tweeterURL = [NSURL URLWithString:@"http://twitter.com/playpixapp"];
    if ([[UIApplication sharedApplication] canOpenURL:tweeterURL]) {
        [[UIApplication sharedApplication] openURL:tweeterURL];
    }

}

-(IBAction)instagramBtnAction:(id)sender
{
    [buttonClickSound play];
    
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://user?username=playpixapp#"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }
        
}

-(IBAction)shareBtnAction:(id)sender
{
    
    [buttonClickSound play];

    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    int v=[currSysVer integerValue];
    if (v<6)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Sharing facility is not available for this version" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        
        //OLD Message
        //Turn up with @pLAypixApp free for iPhone and iPad, #pLAypix\
        //NEW Message
        //Turn up with @playpixapp free for iPhone and iPad! #pLAypix
        
        activityViewController = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObject:@"\"Turn up with @playpixapp free for iPhone and iPad! #pLAypix\""] applicationActivities:nil];
        activityViewController.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeMail, UIActivityTypePostToFacebook, UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll, nil];
        [self presentViewController:activityViewController animated:YES completion:nil];
    }
    
}

-(IBAction)takePhotoBtnAction:(id)sender
{
    
    [buttonClickSound play];
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentModalViewController:imagePicker animated:YES];
    [imagePicker release];
    
}

-(IBAction)myLibraryBtnAction:(id)sender
{
    
    [buttonClickSound play];
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = YES;
    [imagePicker setDelegate:self];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
//        [popover presentPopoverFromRect:self.view.bounds inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//        self.popover = popover;
        
//        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//        imagePickerController.delegate = self;
        popoverController=[[UIPopoverController alloc] initWithContentViewController:imagePicker];
        popoverController.delegate=self;
        [popoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    }
    else
    {
        [self presentModalViewController:imagePicker animated:YES];
    }
}

#pragma mark - UIImagePickerViewDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    selectedImage = image;
    
    if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
    {
       // [popoverController dismissPopoverAnimated:YES];
        
        [self dismissModalViewControllerAnimated:NO];
        
        MenuPage_iPad *menuPageObject = [[MenuPage_iPad alloc] init];
        menuPageObject.menuSelectedImage = selectedImage;
        [self presentModalViewController:menuPageObject animated:NO];
       
    }
    else if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
      
        [self dismissModalViewControllerAnimated:NO];
        
        MenuPage_iPad *menuPageObject = [[MenuPage_iPad alloc] init];
        menuPageObject.menuSelectedImage = selectedImage;
        [self presentModalViewController:menuPageObject animated:YES];

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

#pragma mark - Memory Management Methods

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
