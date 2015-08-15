//
//  HouzifyImageModel.h
//  HouzifyTest
//
//  Created by Bharath Kamath on 15/08/15.
//  Copyright (c) 2015 Bharath -. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HouzifyImageModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *mainImage;

-(id)initWithTitle:(NSString*)text thumb:(NSString*)thumb image:(NSString*)image;
@end
