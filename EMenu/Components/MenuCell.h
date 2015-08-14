//
//  MenuCell.h
//  EMenu
//
//  Created by Chen, Jonny on 11/29/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "Dish.h"
@interface MenuCell : UIView{
    AsyncImageView * dishImage;
    UILabel * dishName;
    UILabel * dishPrice;
    UIButton * addBtn;
    UIButton * cancelBtn;
    UILabel * dishAmount;
}
- (void)loadData;
@property(nonatomic,retain) NSString* imageurl;
@property(nonatomic) int quantity;
@property(nonatomic,retain)Dish* dish;
@end
