//
//  MyUIView.m
//  #pLAypix
//
//  Created by Minakshi on 7/4/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "MyUIView.h"

@implementation MyUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
    NSArray *array = self.subviews;
    
    NSLog(@"array count : %d", [array count]);
    NSLog(@"%@", array);
    
    for( id foundView in self.subviews )
    {
        if( [foundView isKindOfClass:[UIView class]] )
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

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *hitView = [super hitTest:point withEvent:event];
//    if (hitView != self) return [hitView superview];
//    return [self superview];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
