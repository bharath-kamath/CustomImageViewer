//
//  GalleryView.m
//  HouzifyTest
//
//  Created by Bharath Kamath on 15/08/15.
//  Copyright (c) 2015 Bharath -. All rights reserved.
//

#import "GalleryView.h"
#import "HouzifyImageModel.h"
#import "AppDelegate.h"

#define ZOOM_VIEW_TAG 100

@implementation GalleryView

- (id)initWithFrame:(CGRect)frame current:(NSInteger)nowShowing allItems:(NSMutableArray*)items
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        current = nowShowing;
        initialFrame = frame;
        arrItems = items;
        
        self.backgroundColor = [UIColor blackColor];
        self.clipsToBounds = TRUE;
        
        imageScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        imageScrollView.delegate = self;
        [self addSubview:imageScrollView];
        
        [self setupImageView];
        
        lblHeader = [[UILabel alloc] initWithFrame:CGRectZero];
        lblHeader.textColor = [UIColor colorWithRed:0.1882 green:0.7411 blue:0.6 alpha:1.0];
        lblHeader.text = @"Houzify";
        lblHeader.textAlignment = NSTextAlignmentCenter;
        lblHeader.font = [UIFont boldSystemFontOfSize:25];
        lblHeader.backgroundColor = [UIColor clearColor];
        [self addSubview:lblHeader];
        
        lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        lblTitle.textColor = [UIColor colorWithRed:0.1882 green:0.7411 blue:0.6 alpha:1.0];
        lblTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:lblTitle];
    }
    return self;
}

-(void)setupImageView
{
    imageView = [[UIImageView alloc] initWithFrame:imageScrollView.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = TRUE;
    [imageScrollView addSubview:imageView];

    [self setupGestures];
}


-(void)setupGestures {
    
    [imageView setTag:ZOOM_VIEW_TAG];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [doubleTap setNumberOfTapsRequired:2];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [imageView addGestureRecognizer:singleTap];
    [imageView addGestureRecognizer:doubleTap];

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft )];
    [imageView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [imageView addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleUpGesture:)];
    [swipeUp setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [imageView addGestureRecognizer:swipeUp];

    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleDownGesture:)];
    [swipeDown setDirection:(UISwipeGestureRecognizerDirectionDown )];
    [imageView addGestureRecognizer:swipeDown];
    
    
    [imageScrollView setMaximumZoomScale:2.5];
    [imageScrollView setMinimumZoomScale:1.0];
    [imageScrollView setZoomScale:1.0];
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [imageScrollView viewWithTag:ZOOM_VIEW_TAG];
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer
{
    // single tap does nothing for now
    
    isShowing = !isShowing;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (isShowing) {
            lblHeader.frame = CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, 40);
            lblTitle.frame = CGRectMake(5, CGRectGetMaxY(self.frame)-40, CGRectGetWidth(self.frame)-10, 40);
        }
        else
        {
            lblHeader.frame = CGRectMake(5, -40, CGRectGetWidth(self.frame)-10, 40);
            lblTitle.frame = CGRectMake(5, CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame)-10, 40);
        }
        
    }completion:^(BOOL finished){
        
    }];
    
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer
{
    // double tap zooms in
    isZoomed = !isZoomed;
    CGRect zoomRect;
    if(isZoomed)
    {
        float newScale = 2.0;
        zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    }
    else {
        float newScale =  1.0;
        zoomRect = [self zoomRectForScale:newScale withCenter:imageView.center];
    }

    [imageScrollView zoomToRect:zoomRect animated:YES];
}



- (void) leftSwipe:(UISwipeGestureRecognizer *)recognizer{
    current++;
    [self calibrateCount];
    
    UIImageView *ivwMoveLeft = imageView;
    ivwMoveLeft.userInteractionEnabled = FALSE;
    
    [self setupImageView];
    CGRect fr = ivwMoveLeft.frame;
    fr.origin.x = fr.size.width;
    imageView.frame = fr;
    [self showCurrentImage];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        imageView.frame = ivwMoveLeft.frame;
        
        CGRect fr = ivwMoveLeft.frame;
        fr.origin.x = -fr.size.width;
        ivwMoveLeft.frame = fr;
        
    }completion:^(BOOL finished){
        [ivwMoveLeft removeFromSuperview];
    }];
    

}

- (void) rightSwipe:(UISwipeGestureRecognizer *)recognizer{
    current--;
    [self calibrateCount];
    
    UIImageView *ivwMoveRight = imageView;
    ivwMoveRight.userInteractionEnabled = FALSE;
    
    [self setupImageView];
    CGRect fr = ivwMoveRight.frame;
    fr.origin.x = -fr.size.width;
    imageView.frame = fr;
    [self showCurrentImage];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        imageView.frame = ivwMoveRight.frame;
        
        CGRect fr = ivwMoveRight.frame;
        fr.origin.x = fr.size.width;
        ivwMoveRight.frame = fr;
        
    }completion:^(BOOL finished){
        [ivwMoveRight removeFromSuperview];
    }];
}

-(void)calibrateCount{
    if(current<0)
        current = [arrItems count]-1;
    else if (current>= [arrItems count])
        current = 0;
}

- (void) handleUpGesture:(UISwipeGestureRecognizer *)recognizer{
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
//        self.frame = initialFrame;
//        [self setupFrames];
        
        CGRect fr = self.frame;
        fr.origin.y = -fr.size.height;
        self.frame = fr;
        
    }completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

- (void) handleDownGesture:(UISwipeGestureRecognizer *)recognizer{
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
//        self.frame = initialFrame;
//        [self setupFrames];

        CGRect fr = self.frame;
        fr.origin.y = fr.size.height;
        self.frame = fr;
        
    }completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}


- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [imageScrollView frame].size.height / scale;
    zoomRect.size.width  = [imageScrollView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (void)show{
    
    isShowing = TRUE;
    isZoomed = FALSE;
    [self showCurrentImage];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        AppDelegate *appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        self.frame = appdelegate.window.bounds;
        [self setupFrames];

    }completion:^(BOOL finished){

    }];
    
}

-(void)setupFrames
{
    imageScrollView.frame = self.bounds;
    imageView.frame = imageScrollView.bounds;
    lblHeader.frame = CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, 40);
    lblTitle.frame = CGRectMake(5, CGRectGetMaxY(self.frame)-40, CGRectGetWidth(self.frame)-10, 40);
}

- (void)showCurrentImage {
    
    HouzifyImageModel *houze = [arrItems objectAtIndex:current];
    lblTitle.text = houze.title;
    imageView.image = [UIImage imageNamed:houze.mainImage];
}



@end
