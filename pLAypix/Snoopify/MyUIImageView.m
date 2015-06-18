//
//  MyUIImageView.m
//  #pLAypix
//
//  Created by Minakshi on 7/5/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "MyUIImageView.h"

@implementation MyUIImageView

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
    
   
//    NSSet *touches = event.allTouches;
//    
//    UITouch *touch = [touches anyObject];
//    
//    if ([touch tapCount] == 1) {
//        
//        NSLog(@"Single Tap");
//        
//        mainDelegate.singleTapFlag = TRUE;
//        
//    }
//    else if([touch tapCount] == 2)
//    {
//        
//    }
    
//    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
 
//    for (UIView *subview in self.subviews) {
//        CGPoint pointInSubview = [subview convertPoint:point fromView:self];
//        
//
//        if ([subview pointInside:pointInSubview withEvent:event])
//        {
//            NSLog(@"USERINTERACTION = YES");
//            
//            mainDelegate.isUserInterActionEnabled = YES;
//            
//            return YES;
//        }
//        
//    }
    
    
    
    // otherwise return NO, as if userInteractionEnabled were NO
    
//    NSLog(@"USERINTERACTION = NO");
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(mainDelegate.newFlag)
    {
        
        NSLog(@"NewFlag NO : Transparent YES");
        
        return NO;
    }
    
    
    if(mainDelegate.gestureFlag && !mainDelegate.singleTapFlag)
    {
        
        mainDelegate.isUserInterActionEnabled = YES;
        
        return YES;
    }
    else
    {
    
        if(mainDelegate.singleTapFlag)
        {
            
            mainDelegate.isUserInterActionEnabled = YES;
            //NSLog(@"USERINTERACTION = YES");
            return YES;
            
        }
        else
        {

            //NSLog(@"USERINTERACTION = NO");
            
            mainDelegate.isUserInterActionEnabled = NO;
            
            return NO;
        }
    }

//    return NO;
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesBegan:touches withEvent:event];
    
    NSLog(@"TouchesBegan Called");
    
}


- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    
    if (self) {
        
        [self setMultipleTouchEnabled:YES];
        [self setUserInteractionEnabled:YES];
        
//        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
//        panGesture.delegate = self;
//        [super addGestureRecognizer:panGesture];
//        [panGesture addTarget:self action:@selector(dragging:)];
//        
//        UIPinchGestureRecognizer *mypinch = [ [UIPinchGestureRecognizer alloc] init];
//        mypinch.delegate = self;
//        [mypinch addTarget:self action:@selector(myevent:)];
//        [super addGestureRecognizer:mypinch];
//        
//        UIRotationGestureRecognizer *rotateGesture = [ [UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(MyRotationEvent:)];
//        rotateGesture.delegate = self;
//        [super addGestureRecognizer:rotateGesture];
        
        NSLog(@"lkjlkj");
    }
    return self;

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


#pragma mark - UIPanGestureRecognizer Method

- (void) dragging: (UIPanGestureRecognizer*) p
{
    
    CGPoint translation = [p translationInView:self.superview];
    [p setTranslation:CGPointMake(0, 0) inView:self.superview];
    
    CGPoint center = p.view.center;
    center.y += translation.y;
    center.x += translation.x;
    
    NSLog(@"%f", center.x);
    
    p.view.center = center;
    
}

#pragma mark - UIRotationGestureRecognizer Method

-(IBAction)MyRotationEvent:(UIRotationGestureRecognizer *)sender
{
    
    UIRotationGestureRecognizer *gestureRecogniser = (UIRotationGestureRecognizer *) sender;
    gestureRecogniser.view.transform = CGAffineTransformRotate(gestureRecogniser.view.transform, gestureRecogniser.rotation);
    gestureRecogniser.rotation = 0;
    
}

#pragma mark - UIPinchGestureRecognizer Method

-(IBAction)myevent:(UIPinchGestureRecognizer *)sender
{
    
    UIPinchGestureRecognizer *gestureRecognizer = (UIPinchGestureRecognizer *) sender;
    
    if([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        // Reset the last scale, necessary if there are multiple objects with different scales
        lastScale = [gestureRecognizer scale];
    }
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan ||
        [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[[gestureRecognizer view].layer valueForKeyPath:@"transform.scale"] floatValue];
        
        // Constants to adjust the max/min values of zoom
        const CGFloat kMaxScale = 2.5;
        const CGFloat kMinScale = 0.5;
        
        CGFloat newScale = 1 -  (lastScale - [gestureRecognizer scale]); // new scale is in the range (0-1)
        newScale = MIN(newScale, kMaxScale / currentScale);
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale([[gestureRecognizer view] transform], newScale, newScale);
        [gestureRecognizer view].transform = transform;
        
        lastScale = [gestureRecognizer scale];  // Store the previous scale factor for the next pinch gesture call
    }
    
}


//- (UIView *)hitT


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
