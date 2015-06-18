//
//  SharePage_iPad.m
//  pLAypix
//
//  Created by Minakshi on 7/3/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "SharePage_iPad.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "common.h"
#import "AppDelegate.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface SharePage_iPad ()

@end

@implementation SharePage_iPad

@synthesize finalImage, dic;
@synthesize library, backImage;

#pragma mark - UIViewController Delegate Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    w = mainDelegate.window.frame.size.width;
    
    h = mainDelegate.window.frame.size.height;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"buttonClickSound" ofType:@"mp3"];
    buttonClickSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    buttonClickSound.volume = 6.0;
    buttonClickSound.delegate = self;
    
    self.library = [[ALAssetsLibrary alloc] init];
    
    
    UIImageView *lowerBackground = [[UIImageView alloc] init];
    lowerBackground.frame = CGRectMake(0, 0, w, h);
    lowerBackground.image = backImage;
    [self.view addSubview:lowerBackground];
    
    //
    UIImageView *background;
    if(IS_IPHONE_5)
    {
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sharePageBack_iPhone5.png"]];
    }
    else
    {
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sharePageBg_iPhone4.png"]];
        
    }
    
    if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        
        background.frame = CGRectMake(0, -20, w, h);
        
    }
    else
    {
        background.frame = CGRectMake(0, 0, w, h);
        
    }
    
//    background.backgroundColor = [UIColor clearColor];
    [self.view addSubview:background];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
            closeBtn.frame = CGRectMake(270, 45, 40, 40);
            
        }
        else
        {
            closeBtn.frame = CGRectMake(270, 60, 40, 40);
            
        }
        
    }
    else
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
            closeBtn.frame = CGRectMake(271, 4, 40, 40);
            
        }
        else
        {
            closeBtn.frame = CGRectMake(271, 24, 40, 40);
            
        }
        
    }
    [closeBtn setImage:[UIImage imageNamed:@"closeBtn_iPhone5.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    float btnY;
    
    if(IS_IPHONE_5)
    {
        btnY = 105;
    }
    else
    {
        btnY = 70;
    }
    
    for(int i = 1; i < 8; i++)
    {
    
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.tag = i;
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
            shareBtn.frame = CGRectMake(200, btnY, 70, 35);
            
        }
        else
        {
            shareBtn.frame = CGRectMake(200, btnY + 20, 70, 35);
            
        }
        
        [shareBtn setImage:[UIImage imageNamed:@"shareBtnOnSharePage_iPhone5.png"] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:shareBtn];
        
        if(IS_IPHONE_5)
        {
            btnY = btnY + 35 + 15;
        }
        else
        {
            btnY = btnY + 35 + 15;
        }
    }
    
}

-(IBAction)shareBtnAction:(id)sender
{
    
    [buttonClickSound play];
    
    UIButton *btnTapped = (UIButton *)sender;
    
    switch (btnTapped.tag) {
        case 1:
        {
            
            //Save Image to Photo Library
            
//            UIImageWriteToSavedPhotosAlbum(finalImage, self, nil, nil);
            
            UIImageView *rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Right1.png"]];
            rightImage.frame = CGRectMake(0, 0, 20, 20);
            
            hud1 =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud1.frame = CGRectMake(0, 0, 200, 180);
            hud1.center = self.view.center;
            hud1.customView = rightImage;
            
            hud1.mode = MBProgressHUDModeCustomView;
            NSString *strloadingText = [NSString stringWithFormat:@"   Saved!   "];
            hud1.labelText = strloadingText;
            
            [self.library saveImage:finalImage toAlbum:@"pLAypix" withCompletionBlock:^(NSError *error) {
                
                if (error!=nil) {
                    DLog(@"Big error: %@", [error description]);
                }
            }];
            
            [self performSelector:@selector(dismissHUD) withObject:nil afterDelay:1.0];
            
            break;
        }
        case 2:
        {
            //Share image on Instagram
            
            UIImage *image = [self imageWithImage:finalImage scaledToSize:CGSizeMake(612, 612)];
            
            [self shareImageOnInstagram:image];
            
            break;
        }
        case 3:
        {
            //Share image on Facebook
            
            [self shareImageOnFacebook];
            
            break;
        }
        case 4:
        {
            
            //Share image on Twitter
            
            [self shareImageOnTwitter];
            
            break;
        }
        case 5:
        {
            
            //Share image on Email
            
            [self shareImageOnEmail];
            break;
            
        } case 6:
        {
            
            //Share image on MMS
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Graphic Copied!" message:@"Tap and hold in input textfield to paste image for MMS." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alertView.tag = 100;
            [alertView show];
            
            break;
        }
        case 7:
        {
            break;
        }
            
        default:
            break;
    }
    
}

-(void) dismissHUD
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    hud1 = nil;
}

-(IBAction)closeBtnAction:(id)sender
{
    
    [buttonClickSound play];
    
    [self dismissModalViewControllerAnimated:NO];
    
//    [self removeFromParentViewController];
    
//    [mainDelegate.sharePageObj.view removeFromSuperview];
    mainDelegate.sharePageObj = nil;
    
}

#pragma mark - Twitter Sharing

-(void)shareImageOnTwitter
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0") && SYSTEM_VERSION_LESS_THAN(@"6.0"))
    {
    
        Class twitterClass = NSClassFromString(@"TWTweetComposeViewController");   // for backward compatibility
        if(twitterClass) {
            if ([TWTweetComposeViewController canSendTweet]) {   // to check if twitter is set on settings
                
                TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
                
                [tweetViewController setInitialText:@"Turn up with @playpixapp free for iPhone and iPad! #pLAypix"];
                
                if (finalImage != nil) {
                    [tweetViewController addImage:finalImage]; // add image. just as it says
                }
                
                [self presentViewController:tweetViewController animated:YES completion:nil];
                
                // check on this part using blocks. no more delegates? :)
                tweetViewController.completionHandler = ^(TWTweetComposeViewControllerResult res) {
                    if (res == TWTweetComposeViewControllerResultDone) {
                        
                        // Twitter sent successfully.
                        
                    } else if (res == TWTweetComposeViewControllerResultCancelled) {
                        
                        // Tweet cancelled.
                        
                    }
                    [tweetViewController dismissModalViewControllerAnimated:YES];
                    
                    [tweetViewController release];
                };
            } else {
                
                // no twitter set
                
            }
            
        } else {
            //under iOS5
        }
        
    }
    
        else if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
        {
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                SLComposeViewController *tweetSheet = [SLComposeViewController
                                                       composeViewControllerForServiceType:SLServiceTypeTwitter];
                [tweetSheet addImage:finalImage];
                [tweetSheet setInitialText:@"Turn up with @playpixapp free for iPhone and iPad! #pLAypix"];
                [self presentViewController:tweetSheet animated:YES completion:nil];
            }
            else{
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a post to twitter right now. Make sure you have a Twitter account setup for iOS6." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                
            }
        }
    else{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a post to twitter right now. Make sure you have a Twitter account setup for iOS6." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}

#pragma mark - Facebook Sharing

-(void)shareImageOnFacebook
{
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
    {
    
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) //check if Facebook Account is linked
        {
            mySLComposerSheet = [[SLComposeViewController alloc] init]; //initiate the Social Controller
            mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; //Tell him with what social plattform to use it, e.g. facebook or twitter
            [mySLComposerSheet setInitialText:[NSString stringWithFormat:@"Turn up with @playpixapp free for iPhone and iPad! #pLAypix. http://www.playpixapp.com"]]; //the message you want to post
            [mySLComposerSheet addImage:finalImage]; //an image you could post
            //for more instance methodes, go here:https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Reference/SLComposeViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40012205
            [self presentViewController:mySLComposerSheet animated:YES completion:nil];
        }
        else{
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a post to facebook right now. Make sure you have a Facebook account setup for iOS6." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
        
    }
    else{

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a post to facebook right now. Make sure you have a Facebook account setup for iOS6." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];

    }
    
}

#pragma mark - MMS Sharing

-(void)shareimageOnMMS
{
    
   // UIPasteboard *pb = [UIPasteboard generalPasteboard];
    //[pb setImage:finalImage];
    
   // [pb setValue:finalImage forPasteboardType:UIPasteboardNameGeneral];
    
    //[UIPasteboard generalPasteboard].image = finalImage;
    
    UIPasteboard *objPasteboard = [UIPasteboard generalPasteboard];
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(finalImage)];
    [objPasteboard setData:imageData forPasteboardType:@"public.png"];
    
//    NSData* imageData = UIImageJPEGRepresentation(finalImage, 1);
//    NSMutableDictionary *item = [NSMutableDictionary dictionary];
//    [item setValue:imageData forKey:(NSString*)kUTTypeJPEG];
//    [[UIPasteboard generalPasteboard] addItems:[NSArray arrayWithObject:item]];
    
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    NSData *imgData = UIImagePNGRepresentation(finalImage);
//    [pasteboard setData:imgData forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:0]];
    
    NSString *phoneToCall = @"sms:";
    NSString *phoneToCallEncoded = [phoneToCall stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURL *url = [[NSURL alloc] initWithString:phoneToCallEncoded];
    
    [[UIApplication sharedApplication] openURL:url];
    
}

#pragma mark - Email Sharing

-(void)shareImageOnEmail
{
    
    if ([MFMailComposeViewController canSendMail])
    {
        
//        MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
//        emailDialog.mailComposeDelegate = self;
//        NSMutableString *htmlMsg = [NSMutableString string];
//        [htmlMsg appendString:@"<html><body><p>"];
//        [htmlMsg appendString:@"Turn up with @playpixapp free for iPhone and iPad! #pLAypix. http://www.playpixapp.com"];
//        [htmlMsg appendString:@"</p></body></html>"];
//        
//        NSData *jpegData = UIImageJPEGRepresentation(finalImage, 1);
//        
//        NSString *fileName = @"test";
//        fileName = [fileName stringByAppendingPathExtension:@"jpeg"];
//        [emailDialog addAttachmentData:jpegData mimeType:@"image/jpeg" fileName:fileName];
//        
//        [emailDialog setSubject:@"Check this out!"];
//        [emailDialog setMessageBody:htmlMsg isHTML:YES];
//        
//        [self presentModalViewController:emailDialog animated:YES];
//        [emailDialog release];

        
        
        MFMailComposeViewController *picker = [MFMailComposeViewController new];//[[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        [picker setSubject:@"Check this out!"];
        
        
        // Attach an image to the email
       // NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
        NSData *myData = UIImageJPEGRepresentation(finalImage, 1);
        [picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
        
        // Fill out the email body text
        //NSString *emailBody = @"It is raining in sunny California!";
        NSMutableString *htmlMsg = [NSMutableString string];
        [htmlMsg appendString:@"<html><body><p>"];
        [htmlMsg appendString:@"Turn up with @playpixapp free for iPhone and iPad! #pLAypix. http://www.playpixapp.com"];
        [htmlMsg appendString:@"</p></body></html>"];
        [picker setMessageBody:htmlMsg isHTML:YES];
        
        [self presentViewController:picker animated:YES completion:NULL];
        
       // [self presentModalViewController:picker animated:YES];
        
       // [self presentModalViewController:picker animated:YES];

        
        //[picker release];
        
    }
    else {
        
        DLog(@"Device is unable to send email in its current state.");
        
    }
}

#pragma mark - Instagram Sharing

-(void)shareImageOnInstagram:(UIImage*)shareImage
{
    
    //Remember Image must be larger than 612x612 size if not resize it.
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    
    if([[UIApplication sharedApplication] canOpenURL:instagramURL])
    {
        
        CGRect rect = CGRectMake(0 ,0 , 0, 0);
        NSString *documentDirectory=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *saveImagePath=[documentDirectory stringByAppendingPathComponent:@"Image.ig"];
        NSData *imageData=UIImagePNGRepresentation(shareImage);
        [imageData writeToFile:saveImagePath atomically:YES];
        
        NSURL *imageURL=[NSURL fileURLWithPath:saveImagePath];
        
        UIDocumentInteractionController *docController=[[UIDocumentInteractionController alloc]init];
        docController.delegate=self;
        [docController retain];
        docController.UTI = @"com.instagram.photo";
        
        docController.annotation = [NSDictionary dictionaryWithObject:@"@pLAypixApp #pLAypix" forKey:@"InstagramCaption"];
        [docController setURL:imageURL];
        [docController presentOpenInMenuFromRect: rect    inView: self.view animated: YES ];
        
    }
    else
    {
        DLog (@"Instagram not found");
    }
    
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
            
            [self shareimageOnMMS];
            
        }
        else if (buttonIndex == 1){
            DLog(@"Yes clicked");
            
            [self dismissModalViewControllerAnimated:NO];
            //reset clicked
        }
    }
    
}

#pragma mark - MFMessageComposeViewController Delegate Methods

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            DLog(@"Cancelled");
            break;
        case MessageComposeResultFailed:
             DLog(@"Error");
            break;
        case MessageComposeResultSent:
             DLog(@"Message Sent");
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion: nil];
}

#pragma mark - MFMailComposeViewController Delegate Methods

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	//self.feedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			//self.feedbackMsg.text = @"Result: Mail sending canceled";
			break;
		case MFMailComposeResultSaved:
			//self.feedbackMsg.text = @"Result: Mail saved";
			break;
		case MFMailComposeResultSent:
			//self.feedbackMsg.text = @"Result: Mail sent";
			break;
		case MFMailComposeResultFailed:
			//self.feedbackMsg.text = @"Result: Mail sending failed";
			break;
		default:
			//self.feedbackMsg.text = @"Result: Mail not sent";
			break;
	}
    
	[self dismissViewControllerAnimated:NO completion:NULL];
    //[self dismissModalViewControllerAnimated:YES];
    

    

}

//- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
//{
//    if (result == MFMailComposeResultSent)
//    {
//        DLog(@"It's away!");
//    }
//    [self dismissViewControllerAnimated:YES completion:NULL];
//    
//}

#pragma mark - UIDocumentInteractionController Delegate Methods

- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate
{
    
    
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    interactionController.delegate = self;
    
    return interactionController;
}

- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller
{
    
}

- (BOOL)documentInteractionController:(UIDocumentInteractionController *)controller canPerformAction:(SEL)action
{
    return YES;
}

- (BOOL)documentInteractionController:(UIDocumentInteractionController *)controller performAction:(SEL)action
{ 
    return YES;
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application
{
}


#pragma mark - UIWebViewDelegate Methods

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString* urlString = [[request URL] absoluteString];
    NSURL *Url = [request URL];
    NSArray *UrlParts = [Url pathComponents];
    // do any of the following here
    if ([[UrlParts objectAtIndex:(1)] isEqualToString:@"MAMP"]) {
        //if ([urlString hasPrefix: @"localhost"]) {
        NSRange tokenParam = [urlString rangeOfString: @"access_token="];
        if (tokenParam.location != NSNotFound) {
            NSString* token = [urlString substringFromIndex: NSMaxRange(tokenParam)];
            
            // If there are more args, don't include them in the token:
            NSRange endRange = [token rangeOfString: @"&"];
            if (endRange.location != NSNotFound)
                token = [token substringToIndex: endRange.location];
            
            DLog(@"access token %@", token);
            if ([token length] > 0 ) {
                // display the photos here
//                instagramTableViewController *iController = [[instagramPhotosTableViewController alloc] initWithStyle:UITableViewStylePlain];
//                NSString* redirectUrl = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/users/self/feed?access_token=%@", token];
            }
            // use delegate if you want
            //[self.delegate instagramLoginSucceededWithToken: token];
            
        }
        else {
            // Handle the access rejected case here.
            DLog(@"rejected case, user denied request");
        }
        return NO;
    }
    return YES;
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
