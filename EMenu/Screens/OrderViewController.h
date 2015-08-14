//
//  OrderViewController.h
//  EMenu
//
//  Created by Chen, Jonny on 11/29/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "BaseViewController.h"
#import "Restaurant.h"
#import "Dish.h"
#import "AppConstants.h"
@interface OrderViewController : BaseViewController<UITableViewDataSource ,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView * orderList;
    UIView * titleView;
    UIView * totalGroup;
    UIView * seatGroup;
    UIView * submitGroup;
    
    UILabel * _totalQty;
    UILabel * _totalPrc;
    UITextField *_seatNo;
    
    UIButton * confirmBtn;
    UILabel* _succLabel;
    UILabel* _readLabel;
    UIButton * _newOrderBtn;
}
@property(nonatomic,strong)Restaurant* restaurant;
@property(nonatomic,retain) id <AppCallbackDelegate> appCallback;
@end
