//
//  TagsPage_iPad.h
//  Snoopify
//
//  Created by Minakshi on 6/27/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import<AVFoundation/AVAudioPlayer.h>
#import <StoreKit/StoreKit.h>

@interface TagsPage_iPad : UIViewController <AVAudioPlayerDelegate, UIScrollViewDelegate,SKProductsRequestDelegate>
{
    
    AppDelegate *mainDelegate;
    
    UIScrollView *pageScrollView;
    
    AVAudioPlayer *buttonClickSound, *tagsPageBtnSound;
    
    BOOL nextBtnFlag, prevBtnFlag;
    
    float w, h;
    
     //NSArray *_products;
    
    SKProductsRequest *_productsRequest;
    
    NSString *productSelected;
    
}

@end
