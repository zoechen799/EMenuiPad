//
//  Restaurant.h
//  EMenu
//
//  Created by Chen, Jonny on 11/24/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "Dish.h"    
#import "Dish_category.h"

@interface Restaurant : BaseModel
@property(nonatomic)int ID;
@property(nonatomic,retain)NSString * name;
@property(nonatomic,retain)NSString * address;
@property(nonatomic,retain)NSString * alias;
@property(nonatomic,retain)NSString * Description;
// associations
@property(nonatomic)float latitude;
@property(nonatomic)float longitude;
@property(nonatomic,retain) NSString * workdaystart;
@property(nonatomic,retain) NSString * workdayend;
@property(nonatomic,retain) NSString * weekendstart;
@property(nonatomic,retain) NSString * weekendend;
@property(nonatomic,retain) NSMutableArray * pictureUrls;
@property(nonatomic,retain) NSMutableArray * introductions;
@property(nonatomic,retain) NSMutableArray * dish_categories;
@property(nonatomic,retain) NSMutableArray * dishes;
@end
