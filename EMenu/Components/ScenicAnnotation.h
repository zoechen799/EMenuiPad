//
//  ScenicAnnotation.h
//  LeyyGuide
//
//  Created by joey Tranel on 12-1-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ScenicAnnotation : NSObject <MKAnnotation>
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *number;
@property (nonatomic) int ID;
@end
