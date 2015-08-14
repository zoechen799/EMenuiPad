//
//  ChooseRestaurantCtrl.h
//  EMenu
//
//  Created by Chen, Jonny on 11/22/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "BaseViewController.h"

@interface ChooseRestaurantCtrl : BaseViewController <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, retain) UIView * panel;
@property(nonatomic,assign)   id <AppCallbackDelegate> appCallback;
@end
