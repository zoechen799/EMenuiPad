//
//  OrderHelper.m
//  EMenu
//
//  Created by Chen, Jonny on 11/29/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "OrderHelper.h"
#import "AppConstants.h"
@implementation OrderHelper
@synthesize list;
@synthesize amoutDict;
-(id)init
{
    list =[[NSMutableArray alloc] init];
    amoutDict =[[NSMutableDictionary alloc] init];
    return [super init];
}
-(void)dealloc
{
    [list removeAllObjects];
    [list release];
    list = nil;
    [amoutDict removeAllObjects];
    [amoutDict release];
    amoutDict =nil;
    [super dealloc];
}
+(OrderHelper*)sharedOrderHelper
{
    static OrderHelper * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void)emptyDishList
{
    [list removeAllObjects];
    [amoutDict removeAllObjects];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ORDER_CHANGED object:self userInfo:nil];
}
-(void)addDish:(Dish*) dish
{
    for(int i=0;i<list.count;i++){
        if(dish.ID == ((Dish*)[list objectAtIndex: i]).ID)
        {
            NSNumber* _count = [amoutDict objectForKey:[NSNumber numberWithInt:dish.ID]];
            [amoutDict setObject:[NSNumber numberWithInt:([_count intValue] +1)] forKey:[NSNumber numberWithInt:dish.ID]];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ORDER_CHANGED object:self userInfo:nil];
            return;
        }
    }
    [list addObject:dish];
    [amoutDict setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:dish.ID]];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ORDER_CHANGED object:self userInfo:nil];
}
-(void)removeDish:(Dish*)dish{
    for (int i=0; i<list.count; i++) {
        if ([amoutDict objectForKey:[NSNumber numberWithInt:dish.ID]] == nil) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ORDER_CHANGED object:self userInfo:nil];
            return;
        }else{
            NSNumber* _count = [amoutDict objectForKey:[NSNumber numberWithInt:dish.ID]];
            if(_count.intValue >1){
                [amoutDict setObject:[NSNumber numberWithInt:([_count intValue] -1)] forKey:[NSNumber numberWithInt:dish.ID]];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ORDER_CHANGED object:self userInfo:nil];
            }else if(_count.intValue == 1){
                [amoutDict removeObjectForKey:[NSNumber numberWithInt:dish.ID]];
                for (int i=0; i<list.count; i++) {
                    Dish *_item = [list objectAtIndex:i];
                    if (_item.ID == dish.ID) {
                        [list removeObjectAtIndex:i];
                        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ORDER_CHANGED object:self userInfo:nil];
                        break;
                    }
                }
            }else
                return;
        }
    }
}
-(int)totalQuantity
{
    int _quantity =0;
    for (int i=0; i<list.count; i++) {
        Dish *dish = [list objectAtIndex:i];
        NSNumber* _count = [amoutDict objectForKey:[NSNumber numberWithInt:dish.ID]];
        _quantity += [_count intValue];
    }
    return _quantity;
}
-(float)totalPrice
{
    float _price =0;
    for (int i=0; i<list.count; i++) {
        Dish *dish = [list objectAtIndex:i];
        NSNumber* _count = [amoutDict objectForKey:[NSNumber numberWithInt:dish.ID]];
        _price += [_count intValue] * dish.price;
    }
    return _price;
}
-(int)quantityForDish:(Dish*)dish
{
    NSNumber* _count =  [amoutDict objectForKey:[NSNumber numberWithInt:dish.ID]] ;
    return _count.intValue;
}
@end
