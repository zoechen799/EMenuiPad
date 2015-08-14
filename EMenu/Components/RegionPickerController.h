//
//  RegionPickerController.h
//  EMenu
//
//  Created by Chen, Jonny on 11/28/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RegionPickerDelegate
-(void)regionSelected:(NSString *)region;
@end
@interface RegionPickerController : UITableViewController
@property(nonatomic,retain)NSMutableArray *regions;
@property(nonatomic,assign)id<RegionPickerDelegate> delegate;
@end
