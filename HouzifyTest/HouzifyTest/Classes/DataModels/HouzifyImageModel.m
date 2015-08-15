//
//  HouzifyImageModel.m
//  HouzifyTest
//
//  Created by Bharath Kamath on 15/08/15.
//  Copyright (c) 2015 Bharath -. All rights reserved.
//

#import "HouzifyImageModel.h"

@implementation HouzifyImageModel

-(id)initWithTitle:(NSString*)text thumb:(NSString*)thumb image:(NSString*)image{
    self = [super init];
    if (self) {
        self.title =  text;
        self.thumbnail = thumb;
        self.mainImage = image;
    }
    
    return self;
}
@end
