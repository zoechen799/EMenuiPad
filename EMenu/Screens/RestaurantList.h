//
//  RestaurantList.h
//  EMenu
//
//  Created by Chen, Jonny on 11/25/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import <Mapkit/Mapkit.h>
#import "RegionPickerController.h"
#import "BaseViewController.h"
@interface RestaurantList : BaseViewController <UITableViewDataSource ,UITableViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate,RegionPickerDelegate>
{
    UIControl *topBar;
    UIControl *leftTableView;
    UITableView *listView;
    UIControl *detailView;
    NSArray * restaurants;
    MKMapView * mapView;
    CLLocationManager* locationManager;
    UIButton * currentLocationBtn;
    UIPopoverController * regionPop; 
}
@property(nonatomic,assign)   id <AppCallbackDelegate> appCallback;
@end
