//
//  AppDelegate.m
//  EMenu
//
//  Created by Chen, Jonny on 11/22/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "AppDelegate.h"
#import "OrderHelper.h"
#import "DishDetailViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (urlCache == nil && DUMMY == YES) {
        urlCache = [MyURLCache new];
        [NSURLCache setSharedURLCache:urlCache];
    }
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    ChooseRestaurantCtrl* loadingViewController = [[ChooseRestaurantCtrl alloc] init];
    loadingViewController.view.frame = self.window.frame;
    loadingViewController.appCallback = self;
	UINavigationController * rootController = [[UINavigationController alloc] initWithRootViewController:loadingViewController];
	[rootController setNavigationBarHidden:YES];
	[loadingViewController release];
    self.window.rootViewController =rootController;
    [self.window makeKeyAndVisible];
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"canon"
                                         ofType:@"m4a"]];
    NSError * error;
    player =[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!error) {
        player.delegate = self;
        [player prepareToPlay];
        [player play];
    }
    
    return YES;
}
-(void)loadSpliterViewController:(id) restaurant  aBrandNew:(BOOL) cleanCache
{
    if (cleanCache) {
        [masterViewController release];
        masterViewController = nil;
        [masterNavigationController release];
        masterNavigationController = nil;
        [detailViewController release];
        detailViewController =nil;
        [detailNavigationController release];
        detailNavigationController =nil;
    }
    if(masterViewController == nil){
        masterViewController = [[MasterViewController alloc] init];
        masterViewController.appCallback = self;
        if(masterNavigationController==nil){
            masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
        }
    }
    masterViewController.restaurant = restaurant;
    
    if(detailViewController == nil){
        detailViewController = [[DetailViewController alloc] init];
        detailViewController.appCallback = self;
        if (detailNavigationController == nil) {
            detailNavigationController = [[[UINavigationController alloc] initWithRootViewController:detailViewController] autorelease];
        }
    }
    detailViewController.restaurant = restaurant;
    
    masterViewController.detailViewController = detailViewController;
    if (cleanCache) {
        SplitViewControllerRotating * split = [[SplitViewControllerRotating alloc] init] ;
        split.delegate = detailViewController;
        split.viewControllers = @[masterNavigationController, detailNavigationController];
        [UIView transitionWithView:self.window duration:0.8 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            self.window.rootViewController = split;
        } completion:^(BOOL finished){
            if(finished){
                [orderList release];
                orderList = nil;
                [splitController release];
                splitController =nil;
            }}];
    }
    else {
        if(splitController == nil)
        {
            splitController = [[SplitViewControllerRotating alloc] init] ;
            splitController.delegate = detailViewController;
            splitController.viewControllers = @[masterNavigationController, detailNavigationController];
        }
        [UIView transitionWithView:self.window duration:0.8 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            self.window.rootViewController = splitController;
        } completion:nil];
    }
}
-(void)restartOrder:(id)restaurant
{
    [[OrderHelper sharedOrderHelper]emptyDishList];
    if(masterViewController == nil){
        masterViewController = [[MasterViewController alloc] init];
        masterViewController.appCallback = self;
        if(masterNavigationController==nil){
            masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
        }
    }
    masterViewController.restaurant = restaurant;
    
    if(detailViewController == nil){
        detailViewController = [[DetailViewController alloc] init];
        detailViewController.appCallback = self;
        if (detailNavigationController == nil) {
            detailNavigationController = [[[UINavigationController alloc] initWithRootViewController:detailViewController] autorelease];
        }
    }
    detailViewController.restaurant = restaurant;
    
    masterViewController.detailViewController = detailViewController;
    if(splitController == nil){
        splitController = [[SplitViewControllerRotating alloc] init] ;
        splitController.delegate = detailViewController;
        splitController.viewControllers = @[masterNavigationController, detailNavigationController];
    }
    [UIView transitionWithView:self.window duration:0.8 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        self.window.rootViewController = splitController;
    } completion:^(BOOL finished){
        if(finished){
            [orderList release];
            orderList = nil;
            [odNavicontroller release];
            odNavicontroller =nil;
        }
    }];
}
-(void)loadRestaurantList
{
    if(restlist == nil){
        restlist = [[RestaurantList alloc] init];
        restlist.appCallback =self;
        if(rlNavicontroller== nil){
            rlNavicontroller = [[UINavigationController alloc] initWithRootViewController:restlist];
            rlNavicontroller.navigationBarHidden = YES;
        }
    }
    [UIView transitionWithView:self.window duration:0.8 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        self.window.rootViewController = rlNavicontroller;
    } completion:nil];
}
-(void)loadRestaurantShow:(id)obj
{
    if(showRest == nil)
    {
        showRest =[[RestaurantShowCtrl alloc] init];
        showRest.appCallback = self;
        if(rsNavicontroller == nil){
            rsNavicontroller = [[UINavigationController alloc] initWithRootViewController:showRest];
            rsNavicontroller.navigationBarHidden = YES;
        }
    }
    showRest.restaurant = obj;
    [UIView transitionWithView:self.window duration:0.8 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        self.window.rootViewController = rsNavicontroller;
    } completion:nil];
}
-(void)loadOrderList:(id)obj
{
    if(orderList == nil){
        orderList = [[OrderViewController alloc]init];
        orderList.appCallback = self;
        if(odNavicontroller == nil){
            odNavicontroller = [[UINavigationController alloc] initWithRootViewController:orderList];
            odNavicontroller.navigationBarHidden = NO;
        }
    }
    orderList.restaurant =obj;
    [UIView transitionWithView:self.window duration:0.8 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        self.window.rootViewController = odNavicontroller;
    } completion:nil];
}
-(void)backToMenu:(id)obj
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"cameraIrisHollowClose";
    animation.subtype = kCATransitionFromLeft;
    
    if(masterViewController == nil){
        masterViewController = [[MasterViewController alloc] init];
        masterViewController.appCallback = self;
        if(masterNavigationController==nil){
            masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
        }
    }
    masterViewController.restaurant = obj;
    
    if(detailViewController == nil){
        detailViewController = [[DetailViewController alloc] init];
        detailViewController.appCallback = self;
        if (detailNavigationController == nil) {
            detailNavigationController = [[[UINavigationController alloc] initWithRootViewController:detailViewController] autorelease];
        }
    }
    detailViewController.restaurant = obj;
    
    masterViewController.detailViewController = detailViewController;
    if(splitController == nil){
        splitController = [[SplitViewControllerRotating alloc] init] ;
        splitController.delegate = detailViewController;
        splitController.viewControllers = @[masterNavigationController, detailNavigationController];
    }
    orderList.restaurant =obj;
    self.window.rootViewController = splitController;
;
    [[self.window layer] addAnimation:animation forKey:@"animation"];
}
-(void)loadDishDetail:(id)obj
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"cameraIrisHollowOpen";
    animation.subtype = kCATransitionFromLeft;
    dishDetail = [[DishDetailViewController alloc] init];
    NSDictionary * params = (NSDictionary *)obj;
    dishDetail.imageurl = [params objectForKey:@"imageurl"];
    if ([params objectForKey:@"readyImage"]!=nil) {
        dishDetail.readyImage = [params objectForKey:@"readyImage"];
    }
    dishDetail.dish = [params objectForKey:@"dish"];
    dishDetail.quantity =((NSNumber*)[params objectForKey:@"quantity"]).intValue;
    dishDetail.restaurant = [params objectForKey:@"restaurant"];
    dishDetail.appCallback = self;
    UINavigationController* ddNavicontroller =[[UINavigationController alloc] initWithRootViewController:dishDetail];
    self.window.rootViewController = ddNavicontroller;
    [[self.window layer] addAnimation:animation forKey:@"animation"];
}
-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskAll;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    if(player!=nil){
        [player stop];
        player.delegate =  nil;
        [player release];
        player = nil;
    }
}

@end
