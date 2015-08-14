//
//  OrderHelper.h
//  EMenu
//
//  Created by Chen, Jonny on 11/29/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dish.h"

@interface OrderHelper : NSObject

+(OrderHelper*)sharedOrderHelper;
-(void)emptyDishList;
-(void)addDish:(Dish*)dish;
-(void)removeDish:(Dish*)dish;
-(int)totalQuantity;
-(float)totalPrice;
-(int)quantityForDish:(Dish*)dish;

@property(nonatomic,retain) NSMutableArray * list;
@property(nonatomic,retain) NSMutableDictionary * amoutDict;
@end
