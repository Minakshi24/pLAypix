//
//  MyUIImageView.h
//  #pLAypix
//
//  Created by Minakshi on 7/5/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MyUIImageView : UIImageView <UIGestureRecognizerDelegate>
{
    
    AppDelegate *mainDelegate;
    
    CGFloat lastScale;
    CGFloat netrotation;
    
}
@end
