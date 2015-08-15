//
//  GalleryView.h
//  HouzifyTest
//
//  Created by Bharath Kamath on 15/08/15.
//  Copyright (c) 2015 Bharath -. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryView : UIView <UIScrollViewDelegate>
{
    NSMutableArray *arrItems;
    NSInteger current;
    CGRect initialFrame;
    
    UILabel *lblTitle,*lblHeader;
    UIScrollView *imageScrollView;
    UIImageView *imageView;

    BOOL isShowing,isZoomed;
}

- (id)initWithFrame:(CGRect)frame current:(NSInteger)nowShowing allItems:(NSMutableArray*)items;
- (void)show;

@end
