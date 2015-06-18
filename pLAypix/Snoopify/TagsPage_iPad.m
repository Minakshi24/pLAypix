//
//  TagsPage_iPad.m
//  Snoopify
//
//  Created by Minakshi on 6/27/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "TagsPage_iPad.h"
#import "common.h"

#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>
#import "InAppRageIAPHelper.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface TagsPage_iPad ()
{
    NSArray *_products;
}
@end

@implementation TagsPage_iPad

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //_products = [[NSArray alloc] init];
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    w = mainDelegate.window.frame.size.width;
    
    h = mainDelegate.window.frame.size.height;
    
    //In App Purchase
    [self reload];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"buttonClickSound" ofType:@"mp3"];
    buttonClickSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    buttonClickSound.volume = 6.0;
    buttonClickSound.delegate = self;
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"stickerPageBtnSound" ofType:@"mp3"];
    tagsPageBtnSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path1] error:NULL];
    tagsPageBtnSound.volume = 6.0;
    tagsPageBtnSound.delegate = self;
    
    UIImageView *background;
    if(IS_IPHONE_5)
    {
        //NewStickerPageiPhone5
//        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tagsPageBack_iPhone5.png"]];
        //Menu2_5_1
//        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NewStickerPageiPhone5.png"]];
        
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Menu2_5_1.png"]];
    }
    else
    {
//        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stickersPageBg_iPhone4.png"]];
        
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Menu2_4_1.png"]];
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
    [background release];
    
//    UIButton *sticker = [UIButton buttonWithType:UIButtonTypeCustom];
//    sticker.frame = CGRectMake(60, 47, 150, 150);
//    [sticker setImage:[UIImage imageNamed:@"STICKERS1.png"] forState:UIControlStateNormal];
//    [sticker addTarget:self action:@selector(stickerAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:sticker];
//    
//    UIButton *sticker1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    sticker1.frame = CGRectMake(240, 47, 150, 150);
//    [sticker1 setImage:[UIImage imageNamed:@"sticker2.png"] forState:UIControlStateNormal];
//    [sticker1 addTarget:self action:@selector(stickerAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:sticker1];

//    UIImage *prevBtnImage = [UIImage imageNamed:@"prevBtn_iPhone5.png"];
    
    UIImage *prevBtnImage = [UIImage imageNamed:@"BackwardArrow.png"];
    
    UIButton *prevBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
//            prevBtn.frame = CGRectMake(10, 490, prevBtnImage.size.width/2, prevBtnImage.size.height/2);
            
            prevBtn.frame = CGRectMake(5, 483, prevBtnImage.size.width/2, prevBtnImage.size.height/2);
            
        }
        else
        {
//            prevBtn.frame = CGRectMake(10, 510, prevBtnImage.size.width/2, prevBtnImage.size.height/2);
            prevBtn.frame = CGRectMake(5, 503, prevBtnImage.size.width/2, prevBtnImage.size.height/2);
            
        }
        
    }
    else
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
            prevBtn.frame = CGRectMake(10, 417, 36, 45);
            
        }
        else
        {
            prevBtn.frame = CGRectMake(10, 437, 36, 45);
            
        }

        
    }
    [prevBtn setImage:prevBtnImage forState:UIControlStateNormal];
    [prevBtn addTarget:self action:@selector(prevBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:prevBtn];
    
//    UIImage *nextBtnImage = [UIImage imageNamed:@"nextBtn_iPhone5.png"] ;

    UIImage *nextBtnImage = [UIImage imageNamed:@"ForwordArrow.png"] ;
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
//            nextBtn.frame = CGRectMake(60, 490, nextBtnImage.size.width/2, nextBtnImage.size.height/2);
            
            nextBtn.frame = CGRectMake(62, 483, nextBtnImage.size.width/2, nextBtnImage.size.height/2);
            
        }
        else
        {
//            nextBtn.frame = CGRectMake(60, 510, nextBtnImage.size.width/2, nextBtnImage.size.height/2);

            
            nextBtn.frame = CGRectMake(62, 503, nextBtnImage.size.width/2, nextBtnImage.size.height/2);
        }
        
    }
    else
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
            nextBtn.frame = CGRectMake(50, 417, 36, 45);
            
        }
        else
        {
            nextBtn.frame = CGRectMake(50, 437, 36, 45);
            
        }
        
    }
    [nextBtn setImage:nextBtnImage forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
//    UIImage *closeBtnImage = [UIImage imageNamed:@"tagsPageCloseBtn_iPhone5.png"];
    
    UIImage *closeBtnImage = [UIImage imageNamed:@"CloseBtn_New.png"];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
//            closeBtn.frame = CGRectMake(250, 490, closeBtnImage.size.width/2, closeBtnImage.size.height/2);
            
            //Changes on March 18
            closeBtn.frame = CGRectMake(260, 483, closeBtnImage.size.width/2, closeBtnImage.size.height/2);
            
        }
        else
        {
//            closeBtn.frame = CGRectMake(250, 510, closeBtnImage.size.width/2, closeBtnImage.size.height/2);
            closeBtn.frame = CGRectMake(260, 503, closeBtnImage.size.width/2, closeBtnImage.size.height/2);
            
        }
        
    }
    else
    {
        if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
        {
            
            closeBtn.frame = CGRectMake(270, 417, 36, 45);
            
        }
        else
        {
            closeBtn.frame = CGRectMake(270, 437, 36, 45);
            
        }
        
    }
    [closeBtn setImage:closeBtnImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
//    UIView *backView = [[UIView alloc] init];
//    backView.frame = CGRectMake(50, 0, 668, 900);
//    backView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:backView];
    
    pageScrollView = [[UIScrollView alloc] init];
    if(IS_IPHONE_5)
    {
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            pageScrollView.frame = CGRectMake(0, 0, w, h - 92 + 20);
        }
        else
        {
            pageScrollView.frame = CGRectMake(0, 0, w, h - 92);
        }
        
    }
    else
    {
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            pageScrollView.frame = CGRectMake(0, 0, w, h - 50 + 20);
        }
        else
        {
//            pageScrollView.frame = CGRectMake(0, 0, w, h - 50);
            
            pageScrollView.frame = CGRectMake(0, 0, w, h - 65);
        }
        
        
    }
    pageScrollView.backgroundColor = [UIColor clearColor];
    pageScrollView.showsHorizontalScrollIndicator = NO;
    pageScrollView.delegate = self;
    pageScrollView.pagingEnabled = YES;
    pageScrollView.bounces = FALSE;
    pageScrollView.userInteractionEnabled = YES;
    [self.view addSubview:pageScrollView];
    pageScrollView.contentSize = CGSizeMake(w*12, pageScrollView.frame.size.height);
    
    float btnX = 8;
    
    float btnY = 10;
    
    int k = 1;
    
    for(int i = 1; i < 13; i++)
    {
        
        DLog(@"%d", i);
        
        btnX = 320 * (i - 1) + 8;//690 * (i - 1);
        
        if(IS_IPHONE_5)
        {
            if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
            {
                btnY = 20;
            }
            else
            {
               btnY = 40;
                
            }
            
        }
        else
        {
            if(SYSTEM_VERSION_LESS_THAN(@"7.0"))
            {
                btnY = 10;
            }
            else
            {
                btnY = 30;
            }

        }
        for(int j = 1; j < 21; j++)
        {
            
            UIButton *sticker = [UIButton buttonWithType:UIButtonTypeCustom];
            sticker.tag = k;
            if(IS_IPHONE_5)
            {
               sticker.frame = CGRectMake(btnX, btnY, 70, 70);
                
            }
            else
            {
                sticker.frame = CGRectMake(btnX, btnY, 70, 70);
            }
            
            [sticker setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Sticker%d.png", k]] forState:UIControlStateNormal];
            [sticker addTarget:self action:@selector(stickerAction:) forControlEvents:UIControlEventTouchUpInside];
            [pageScrollView addSubview:sticker];
            
            k++;
            
            if(j % 4 == 0)
            {
                btnX = 320 * (i - 1) + 8;
                if(IS_IPHONE_5)
                {
                    btnY = btnY + 70 + 19;
                }
                else
                {
                    btnY = btnY + 70 + 8;
                }
            }
            else
            {
                btnX = btnX + 70 + 8;
            }
            
            if(i == 9 && j == 16)
            {
                break;
            }
            
        }
        
    }
    
    //In app purchase transparent background setting
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL productPurchased = FALSE;
    int transBackX = 9;
    int transBackTag = 800;
    int btnTag = 1000;
    for(int i = 1; i < 4; i++)
    {
        productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"Set%d",i]];
        
        NSLog(@"productPurchased Set%d: %d", i, productPurchased);
    
        if(!productPurchased)
        {
//            if(IS_IPHONE_5)
//            {
            
                    UIView *transparentBack = [[UIView alloc] init];//[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iPhone5TransBack.png"]];
                    transparentBack.userInteractionEnabled = YES;
                    transparentBack.tag = transBackTag;
                    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                    {
                        transparentBack.frame = CGRectMake(transBackX*w, 0, w, pageScrollView.frame.size.height);
                    }
                    else
                    {
                        transparentBack.frame = CGRectMake(transBackX*w, 0, w, pageScrollView.frame.size.height);
                    }
                    
                    transparentBack.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iPhone5TransBack.png"]];
                    [pageScrollView addSubview:transparentBack];
                    
                    int btnX = (transparentBack.frame.size.width - 70)/2;
                    int btnY = (transparentBack.frame.size.height - 93)/2;
                              
                    UIButton *lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    lockBtn.tag = btnTag;
                    lockBtn.center = transparentBack.center;
                    lockBtn.frame = CGRectMake(btnX, btnY, 70, 93);//CGRectMake(w/2 - 25, (h - 55)/2 - 25, 100, 132);
                    [lockBtn setImage:[UIImage imageNamed:@"STICKER_LOCK.png"] forState:UIControlStateNormal];
                    [lockBtn addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                    [transparentBack addSubview:lockBtn];

//            }
//            else
//            {
//                UIView *transparentBack = [[UIView alloc] init];//[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iPhone5TransBack.png"]];
//                transparentBack.frame = CGRectMake(9*w, 0, w, h);
//                transparentBack.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iPhone5TransBack.png"]];
//                [pageScrollView addSubview:transparentBack];
//            }
            
            transBackX++;
            transBackTag++;
            btnTag++;
            
        }
        else
        {
            transBackX++;
            transBackTag++;
            btnTag++;
        }
    }
    
}

//- (void)reload {
//    _products = nil;
//    
//    NSLog(@"Product List : %@",[InAppRageIAPHelper sharedHelper].products);
//    
//    [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
//        if (success) {
//            _products = products;
//            
//            NSLog(@"_products : %@", _products);
//            
//        }
//    }];
//}


- (void)reload {
    //_products = nil;
//    [self.tableView reloadData];
    [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = [[NSArray alloc] initWithArray:products];
             NSLog(@"_products : %@", _products);
//            [self.tableView reloadData];
        }
//        [self.refreshControl endRefreshing];
    }];
}


- (void)buyButtonTapped:(id)sender {
    
    NSLog(@"buyButtonTapped %@", _products);
    
    UIButton *buyButton = (UIButton *)sender;
    
    int index = buyButton.tag - 1000;
    
    SKProduct *product = (SKProduct *)[_products objectAtIndex:index];
    
    productSelected = product.productIdentifier;
    
    NSLog(@"Buying %@...", product.productIdentifier);
    [[RageIAPHelper sharedInstance] buyProduct:product];
    
}

-(IBAction)closeBtnAction:(id)sender
{
    
    [buttonClickSound play];
    
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)nextBtnAction:(id)sender
{
    [tagsPageBtnSound play];
    
   // DLog(@"pageScrollView.contentOffset : %f ", pageScrollView.contentOffset.x);
    
//    if(!nextBtnFlag)
//    {
//        
//        if(pageScrollView.contentOffset.x < 668*9)
//        {
//            nextBtnFlag = TRUE;
//            
//    //        pageScrollView.contentOffset = CGPointMake(pageScrollView.contentOffset.x+668, 0);
//            [pageScrollView setContentOffset:CGPointMake(pageScrollView.contentOffset.x+668, 0) animated:YES];
//            
//            [self performSelector:@selector(changeNextBtnFlag) withObject:nil afterDelay:0.2];
//            
//        }
//    }

    if(pageScrollView.contentOffset.x < w*11)
    {
    
        CGPoint offset = CGPointMake(pageScrollView.contentOffset.x+w,
                                     pageScrollView.contentOffset.y);
      
        [UIView animateWithDuration:.2
                              delay:0
                            options:UIViewAnimationTransitionFlipFromLeft
                         animations:^{
                             [pageScrollView setContentOffset:offset animated:NO];
                         } completion:nil];
        
//        [UIView animateWithDuration:.01 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//            [pageScrollView setContentOffset:offset];
//        }completion:nil];
        
    }

}

-(IBAction)prevBtnAction:(id)sender
{
    [tagsPageBtnSound play];
    
    if(pageScrollView.contentOffset.x > 0)
    {
//        pageScrollView.contentOffset = CGPointMake(60, 0);
//        [pageScrollView setContentOffset:CGPointMake(pageScrollView.contentOffset.x-668, 0) animated:YES];
        
        CGPoint offset = CGPointMake(pageScrollView.contentOffset.x-w,
                                     pageScrollView.contentOffset.y);
        
        [UIView animateWithDuration:.2
                              delay:0
                            options:UIViewAnimationTransitionFlipFromRight
                         animations:^{
                             [pageScrollView setContentOffset:offset animated:NO];
                         } completion:nil];
    }
}

-(IBAction)stickerAction:(id)sender
{
    
    [buttonClickSound play];
    
    UIButton *btn = (UIButton *)sender;
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"OriginalSticker%d.png", btn.tag]];
    
    mainDelegate.selectedImageFromTagPage = image;
    [mainDelegate.selectedImageFromTagPage setAccessibilityIdentifier:[NSString stringWithFormat:@"FlippedSticker%d.png", btn.tag]];
    
    [self dismissModalViewControllerAnimated:NO];
}

#pragma mark - In App Purchase Methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
//            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            //*stop = YES;
            
            NSLog(@"Purchase complete %@", productIdentifier);
            
            if([productIdentifier isEqualToString:@"Set1"])
            {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Set1"];
                [[NSUserDefaults standardUserDefaults] synchronize];

             
                UIView *viewToBeRemoved = (UIView *)[pageScrollView viewWithTag:800];
                if(viewToBeRemoved != nil)
                {
                    NSLog(@"Set1 removed");
                    
                    [viewToBeRemoved removeFromSuperview];
                    viewToBeRemoved = nil;
                }
            }
            else if([productSelected isEqualToString:@"Set2"])
            {
                UIView *viewToBeRemoved = (UIView *)[pageScrollView viewWithTag:801];
                if(viewToBeRemoved != nil)
                {
                    
                    NSLog(@"Set2 removed");
                    [viewToBeRemoved removeFromSuperview];
                    viewToBeRemoved = nil;
                }
            }
            else if([productSelected isEqualToString:@"Set3"])
            {
                UIView *viewToBeRemoved = (UIView *)[pageScrollView viewWithTag:802];
                if(viewToBeRemoved != nil)
                {
                    NSLog(@"Set3 removed");
                    
                    [viewToBeRemoved removeFromSuperview];
                    viewToBeRemoved = nil;
                }
            }
            
        }
    }];
    
}


#pragma mark - UIScrollViewDelegate Methods

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
}

-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [tagsPageBtnSound play];
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
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
