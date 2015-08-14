//
//  MenuModel.h
//  EMenu
//
//  Created by Chen, Jonny on 11/24/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "Dish_category.h"
#import "Restaurant.h"
@interface Dish : BaseModel
{
    int logoId;
}
@property(nonatomic) int ID;
@property(nonatomic,retain) NSString * name;
@property(nonatomic) float price;
@property(nonatomic,retain) NSString * Description;
@property(nonatomic,retain) NSMutableArray * dishPictures;
@property(nonatomic,retain) NSString * logo_id;
@property(nonatomic,retain) NSString * logourl;

@end
