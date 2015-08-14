//
//  MenuModel.m
//  EMenu
//
//  Created by Chen, Jonny on 11/24/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "Dish.h"
#import "Dish_picture.h"
@implementation Dish
@synthesize ID;
@synthesize name;
@synthesize price;
@synthesize Description;
@synthesize dishPictures;
@synthesize logo_id;
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
    if ([@"Dish_picture" isEqualToString:key]){
        if(self.dishPictures == nil){
            self.dishPictures =[[NSMutableArray alloc] init];
        }
        for (int i=0; i<[arr count]; i++) {
            NSDictionary * _dishpic = [arr objectAtIndex:i];
            NSDictionary * _wrapper = [NSDictionary dictionaryWithObject:_dishpic forKey:@"Dish_picture"];
            Dish_picture *dp = [[Dish_picture alloc] initWithJSON:_wrapper];
            [self.dishPictures addObject:dp];
        }
    }
}
-(NSString *)logourl
{
    if (logo_id!=nil &&[logo_id isKindOfClass:[NSString class]] && [logo_id rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound) {
        if([logo_id intValue] < [dishPictures count]){
            return ((Dish_picture* ) [dishPictures objectAtIndex:[logo_id intValue]]).filepath;
        }
        else
        {
            return  ((Dish_picture* ) [dishPictures objectAtIndex:0]).filepath;
        }
    }else if(dishPictures!=nil && [dishPictures count]>0){
        Dish_picture* _pic =[dishPictures objectAtIndex:0];
        return  _pic.filepath;
    }
    return nil;
}
@end
