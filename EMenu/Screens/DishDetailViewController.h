//
//  DishDetailViewController.h
//  EMenu
//
//  Created by Chen, Jonny on 12/1/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "BaseViewController.h"
#import "Dish.h"
#import "AsyncImageView.h"
#import "AppConstants.h"
@interface DishDetailViewController : BaseViewController{
    UIImageView * dishImage;
    UILabel * dishName;
    UILabel * dishPrice;
    UIView * panel;
    UIButton * addBtn;
    UIButton * cancelBtn;
    UILabel * dishAmount;
}
@property(nonatomic,retain) NSString* imageurl;
@property(nonatomic) int quantity;
@property(nonatomic,retain)Dish* dish;
@property(nonatomic,retain)UIImage *readyImage;
@property(nonatomic,retain)Restaurant* restaurant;
@property(nonatomic,retain) id <AppCallbackDelegate> appCallback;
@end
