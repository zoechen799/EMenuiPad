//
//  ScenicAnnotation.m
//  LeyyGuide
//
//  Created by joey Tranel on 12-1-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScenicAnnotation.h"


@implementation ScenicAnnotation
@synthesize image;
@synthesize coordinate;
@synthesize title;
@synthesize number;
@synthesize ID;
- (void)dealloc
{
    [image release];
    [title release];
    [number release];
    [super dealloc];
}


@end
