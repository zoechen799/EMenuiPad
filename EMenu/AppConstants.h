//
//  AppConstants.h
//  EMenu
//
//  Created by Chen, Jonny on 11/24/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#ifndef EMenu_AppConstants_h
#define EMenu_AppConstants_h

#define DUMMY YES
#define TOPHEIGHT 60
#define LEFTWIDTH 250
#define RESTAURANTCELLHEIGHT 120
#define MINIMUM_ZOOM_ARC 0.014 //approximately 1 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.15
#define MAX_DEGREES_ARC 360
#define NOTIFICATION_MODEL_FETCHING @"notifyfetch"
#define NOTIFICATION_MODEL_CHANGED @"notifychanged"
#define NOTIFICATION_ORDER_CHANGED @"notifyorder"
#define NOTIFICATION_SHOWDETAIL @"notifydetail"
#define NUMBERPERMENUPAGE 4
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0];

@protocol AppCallbackDelegate<NSObject>
@optional
-(void)loadSpliterViewController:(id) data aBrandNew:(BOOL) cleanCache;
-(void)loadRestaurantList;
-(void)loadRestaurantShow:(id)obj;
-(void)loadOrderList:(id)obj;
-(void)backToMenu:(id)obj;
-(void)loadDishDetail:(id)obj;
-(void)restartOrder:(id)obj;
@end
#endif
