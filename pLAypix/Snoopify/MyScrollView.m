//
//  MyScrollView.m
//  #pLAypix
//
//  Created by Minakshi on 7/16/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // If one of our subviews wants it, return YES
    //    for (UIView *subview in self.subviews) {
    //        CGPoint pointInSubview = [subview convertPoint:point fromView:self];
    //        if ([subview pointInside:pointInSubview withEvent:event]) {
    //            return YES;
    //        }
    //    }
    //    // otherwise return NO, as if userInteractionEnabled were NO
    //    return NO;
    
    
    //    for (UIView *view in self.subviews) {
    //        if (!view.hidden && view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event])
    //            return YES;
    //    }
    //    return NO;
    
    NSArray *array = self.subviews;
    
    NSLog(@"array count : %d", [array count]);
    NSLog(@"%@", array);
    
    for( id foundView in self.subviews )
    {
        if( [foundView isKindOfClass:[UIImageView class]] || [foundView isKindOfClass:[UIScrollView class]])
        {
            UIView *foundButton = foundView;
            
            if( !foundButton.hidden &&  [foundButton pointInside:[self convertPoint:point toView:foundButton] withEvent:event] )
            {
                NSLog(@"Inside IF");
                
                return YES;
            }
            NSLog(@"Outside IF2");
        }
        NSLog(@"Outside IF1");
    }
    
    NSLog(@"Outside IF");
    return NO;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    // If not dragging, send event to next responder
    if (!self.dragging){
        [self.nextResponder touchesBegan: touches withEvent:event];
    }
    else{
        [super touchesEnded: touches withEvent: event];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView != self) return [hitView superview];
    return [self superview];
}


@end
