//
//  OrderListCell.h
//  EMenu
//
//  Created by Chen, Jonny on 11/30/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dish.h"
@interface OrderListCell : UITableViewCell
{
    UIButton * addBtn;
    UIButton * cancelBtn;
    UILabel * nameLabel;
    UILabel * priceLabel;
    UILabel * quantityLabel;
    UILabel * totalPriceLabel; 
    Dish* _dish;
    int _qty;
}
@property(nonatomic)int dishQuantity;
@property(nonatomic,retain)Dish* dish;
@end
