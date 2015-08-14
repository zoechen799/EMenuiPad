//
//  Dish_category.h
//  EMenu
//
//  Created by Chen, Jonny on 11/24/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface Dish_category : BaseModel
@property(nonatomic) int ID;
@property(nonatomic,retain) NSString * name;
@property(nonatomic,retain) NSString * name_en;
@end
