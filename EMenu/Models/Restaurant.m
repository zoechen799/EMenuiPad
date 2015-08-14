//
//  Restaurant.m
//  EMenu
//
//  Created by Chen, Jonny on 11/24/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant
@synthesize ID;
@synthesize name;
@synthesize alias;
@synthesize Description;
@synthesize address;
@synthesize latitude;
@synthesize longitude;
@synthesize workdaystart;
@synthesize workdayend;
@synthesize weekendstart;
@synthesize weekendend;
@synthesize pictureUrls;
@synthesize dish_categories;
@synthesize dishes;
-(void)addAssocaitions:(id)dic forKey:(NSString *)key
{
    
    NSDictionary * obj;
    NSArray * arr;
    if([dic isKindOfClass:[NSDictionary class]])
        obj  =dic;
    else if([dic isKindOfClass:[NSArray class]])
        arr = dic;
    else
        return;
    
    
    if ([@"Restaurant_coordinate" isEqualToString:key]) {
        NSString *_lat, *_lon;
        if(( _lat =[obj objectForKey:@"latitude"] )!=nil && (_lon= [obj objectForKey:@"longitude"])!=nil)
        {
            self.latitude = _lat.floatValue;
            self.longitude = _lon.floatValue;
        }
    }
    else if ([@"Restaurant_workinghour" isEqualToString:key]){
        NSString *_s, *_d, *_ws, *_wd ;
        if(( _s =[obj objectForKey:@"workdaystart"] )!=nil
           && (_d= [obj objectForKey:@"workdayend"])!=nil
           && (_ws= [obj objectForKey:@"weekendstart"])!=nil
           && (_wd= [obj objectForKey:@"weekendend"])!=nil)
        {
            self.workdaystart =_s;
            self.workdayend = _d;
            self.weekendstart = _ws;
            self.weekendend = _wd;
        }
    }
    else if ([@"Restaurant_picture" isEqualToString:key]){
        if(self.pictureUrls==nil)
            self.pictureUrls = [[NSMutableArray alloc] init];
        for (int i=0; i< [arr count]; i++) {
            NSDictionary * _pic = [arr objectAtIndex:i];
            [self.pictureUrls addObject:[_pic objectForKey:@"filepath"]];
        }
    }
    else if ([@"Restaurant_introduction" isEqualToString:key]){
        if(self.introductions==nil)
            self.introductions = [[NSMutableArray alloc] init];
        for (int i=0; i< [arr count]; i++) {
            NSDictionary * _intro = [arr objectAtIndex:i];
            [self.introductions addObject:[_intro objectForKey:@"introduction"]];
        }
    }
    else if ([@"Dish_category" isEqualToString:key]){
        if (self.dish_categories == nil) {
            self.dish_categories = [[NSMutableArray alloc] init];
        }
        for (int i=0; i<[arr count]; i++) {
            NSDictionary * _cat = [arr objectAtIndex:i];
            NSDictionary * _wrapper = [NSDictionary dictionaryWithObject:_cat forKey:@"Dish_category"];
            Dish_category *category = [[Dish_category alloc] initWithJSON:_wrapper];
            [self.dish_categories addObject:category];
        }
    }
    else if ([@"Dish" isEqualToString:key]){
        if(self.dishes == nil){
            self.dishes =[[NSMutableArray alloc] init];
        }
        for (int i=0; i<[arr count]; i++) {
            NSDictionary * _dish = [arr objectAtIndex:i];
            NSDictionary * _wrapper = [NSDictionary dictionaryWithObject:_dish forKey:@"Dish"];
            Dish *dish = [[Dish alloc] initWithJSON:_wrapper];
            [self.dishes addObject:dish];
        }
    }
}
@end
