//
//  MasterViewController.h
//  dd
//
//  Created by Chen, Jonny on 11/21/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "Restaurant.h"
@class DetailViewController;

@interface MasterViewController : UIViewController <UITableViewDataSource , UITableViewDelegate>
{
    UITableView * defaultTable;
    CGRect originalSize;
    UITableView * categoryList;
}
@property (strong, nonatomic) DetailViewController *detailViewController;
@property(nonatomic,assign)   id <AppCallbackDelegate> appCallback;
@property(nonatomic, retain) Restaurant * restaurant;
@end
