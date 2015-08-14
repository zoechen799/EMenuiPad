//
//  Dish_picture.h
//  EMenu
//
//  Created by Chen, Jonny on 11/29/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "BaseModel.h"

@interface Dish_picture : BaseModel
@property(nonatomic) int ID;
@property(nonatomic,retain) NSString * name;
@property(nonatomic,retain) NSString * hashcode;
@property(nonatomic,retain) NSString * filepath;
@end
