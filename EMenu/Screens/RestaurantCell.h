//
//  RestaurantCell.h
//  EMenu
//
//  Created by Chen, Jonny on 11/26/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIStar.h"

@interface RestaurantCell : UITableViewCell
@property (nonatomic,retain) UILabel * restaurantName;
@property (nonatomic,retain) UILabel * address;
@property (nonatomic,retain) UIStar * star;
@end
