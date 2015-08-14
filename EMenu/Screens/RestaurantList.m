//
//  RestaurantList.m
//  EMenu
//
//  Created by Chen, Jonny on 11/25/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "RestaurantList.h"
#import "Restaurant.h"
#import "RestaurantCell.h"
#import "ScenicAnnotation.h"
#import "GenericDAO.h"
#import "RegionPickerController.h"

@interface RestaurantList ()

@end

@implementation RestaurantList
@synthesize appCallback;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addTopBar];
    [self addLeftTable];
    [self loadRestaurants];
    [self addDetailView];
    locationManager =[[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.distanceFilter = 10.0f;
    [locationManager startUpdatingLocation];
}
- (void)viewWillLayoutSubviews{
    topBar.frame = CGRectMake(0, 0, self.view.frame.size.width, TOPHEIGHT);
    leftTableView.frame = CGRectMake(0, TOPHEIGHT, LEFTWIDTH, self.view.frame.size.height - TOPHEIGHT);
    listView.frame =CGRectMake(0, 5, LEFTWIDTH-5, leftTableView.frame.size.height -50);
    listView.rowHeight = RESTAURANTCELLHEIGHT;
    mapView.frame = CGRectMake(LEFTWIDTH+2, TOPHEIGHT+2, self.view.frame.size.width-LEFTWIDTH-4, self.view.frame.size.height-TOPHEIGHT-4);
    currentLocationBtn.frame = CGRectMake(self.view.frame.size.width -65, 150, 44, 44);
}

-(void)loadRestaurants
{
    [[GenericDAO sharedGenericDAO]find:[Restaurant class] withParameters:nil completionHandler:^(NSArray* array){
        restaurants = array;
        [restaurants retain];
        [self performSelectorOnMainThread:@selector(updateTable) withObject:nil waitUntilDone:NO ];
        
    }];
}
-(void)updateTable
{
    NSMutableArray * insertion =[[NSMutableArray alloc] init];
    for (int i=0; i<[restaurants count]; i++) {
        [insertion addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [listView beginUpdates];
    if ([listView numberOfRowsInSection:0] >0) {
        NSMutableArray *arr =[[NSMutableArray alloc] init];
        for (int i=0; i<[listView numberOfRowsInSection:0]; i++) {
            [arr addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [listView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    }
    [listView insertRowsAtIndexPaths:insertion withRowAnimation:UITableViewRowAnimationNone];
    [listView endUpdates];
    [self updateAnnotations];
}
-(void)addTopBar
{
    CGRect pFrame = self.view.frame;
    topBar = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, pFrame.size.width, TOPHEIGHT)];
    topBar.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg2.jpg"]];
    UIButton * btnArea =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnArea setTitle:@"选择商区" forState:UIControlStateNormal];
    [btnArea setTitle:@"选择商区" forState:UIControlStateHighlighted];
    [btnArea setTitle:@"选择商区" forState:UIControlStateDisabled];
    [btnArea setTitle:@"选择商区" forState:UIControlStateSelected];
    [btnArea setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnArea setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [btnArea setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [btnArea setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    btnArea.titleLabel.font   = [UIFont systemFontOfSize: 18];
    btnArea.frame = CGRectMake(100, 30, 100, 32);
    [btnArea addTarget:self action:@selector(onChangeRegionClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * icon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_dropdown.png"]];
    icon1.frame = CGRectMake(88,7,18,18);
    [btnArea addSubview:icon1];
    [icon1 release];
    [topBar addSubview:btnArea];
    [self.view addSubview:topBar];
    [topBar release];
}
-(void) onChangeRegionClicked:(id)sender
{
    RegionPickerController * regionSel = [[[RegionPickerController alloc] initWithStyle:UITableViewStylePlain]autorelease];
    regionSel.delegate = self;
    regionPop = [[UIPopoverController  alloc] initWithContentViewController:regionSel] ;
    [regionPop presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
-(void)regionSelected:(NSString *)region
{
    
}
-(void)addLeftTable
{
    leftTableView = [[UIControl alloc]initWithFrame:CGRectMake(0, TOPHEIGHT, LEFTWIDTH, self.view.frame.size.height - TOPHEIGHT)];
    leftTableView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg2.jpg"]];
    listView =[[UITableView alloc] initWithFrame:CGRectMake(0, 5, LEFTWIDTH-5, leftTableView.frame.size.height -50) style:UITableViewStyleGrouped];
    listView.backgroundColor =[UIColor clearColor];
    listView.dataSource =self;
    listView.delegate =self;
    [leftTableView addSubview:listView];
    [self.view addSubview:leftTableView];
}
-(void)addDetailView
{
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(LEFTWIDTH+2, TOPHEIGHT+2, self.view.frame.size.width-LEFTWIDTH-4, self.view.frame.size.height-TOPHEIGHT-4)];
    mapView.delegate = self;
    [self.view addSubview:mapView];
    
    currentLocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    currentLocationBtn.frame = CGRectMake(self.view.frame.size.width -65, 150, 44, 44);
    [currentLocationBtn setImage:[UIImage imageNamed:@"locateBtn.png"] forState:UIControlStateNormal];
    [currentLocationBtn addTarget:self action:@selector(onCurrentLocationClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:currentLocationBtn];
}
-(void)onCurrentLocationClicked:(id)sender
{
    mapView.showsUserLocation = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return restaurants.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( (RESTAURANTCELLHEIGHT +5)  * restaurants.count < leftTableView.frame.size.height -50)
        listView.frame =CGRectMake(0, 5, LEFTWIDTH-5, (RESTAURANTCELLHEIGHT +5)  * restaurants.count);
    return RESTAURANTCELLHEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RestaurantCellIdentifier";
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[RestaurantCell alloc] init];
    }
    Restaurant * rst = [restaurants objectAtIndex:indexPath.row];
    cell.restaurantName.text = rst.name;
    cell.address.text =rst.address;
    cell.tag =rst.ID;
    cell.star.star = 1;
    cell.frame = CGRectMake(0.0, 0.0, 200.0, RESTAURANTCELLHEIGHT);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Restaurant * rst = [restaurants objectAtIndex:indexPath.row];
    NSArray * annos =mapView.annotations;
    for (id <MKAnnotation> anot  in annos) {
        if ([anot isMemberOfClass:[ScenicAnnotation class]]) {
            if( ((ScenicAnnotation * )anot).ID == rst.ID){
                [mapView selectAnnotation: anot animated:YES];
            }
        }
    }
}
- (void)showDetails:(id)sender
{
    if([sender isKindOfClass:[UIButton class]])
    {
        int tag = ((UIButton *) sender).tag;
        for (Restaurant *r in restaurants) {
            if(r.ID == tag && appCallback!=nil)
            {
                [appCallback loadRestaurantShow:r];
                break;
            }
        }
    }
}
-(void) updateAnnotations
{
    @try{
        if(mapView.annotations!= nil && [mapView.annotations count]>0)
        {
            NSArray * annos =mapView.annotations;
            for (id <MKAnnotation> anot  in annos) {
                if ([anot isMemberOfClass:[ScenicAnnotation class]]) {
                    [mapView removeAnnotation:anot];
                }
            }
        }
    }@catch (NSException *ex) {
        NSLog(@"清除Annotations失败");
    }
    for(Restaurant* row in restaurants)
    {
        float fLat = row.latitude;
        float fLnt = row.longitude;
        if(fLat !=0 && fLnt!=0){
            CLLocationCoordinate2D theCoordinate;
            theCoordinate.latitude = fLat;
            theCoordinate.longitude = fLnt;
            ScenicAnnotation * anno =[[ScenicAnnotation alloc]init];
            anno.coordinate =theCoordinate;
            NSString * imgName = @"wagas_logo.jpg";
            anno.image  = [UIImage imageNamed:imgName];
            anno.title = row.name;
            anno.number =[NSString stringWithFormat:@"%d",row.ID];
            anno.ID = row.ID;
            [mapView addAnnotation:anno];
        }
    }
}
#pragma mark -
#pragma mark MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[ScenicAnnotation class]])
    {
        static NSString* scenicAnnotationIdentifier = @"scenicAnnotationIdentifier";
        {
            MKAnnotationView *annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:scenicAnnotationIdentifier] autorelease];
            annotationView.canShowCallout = YES;
            NSString * number = ((ScenicAnnotation *) annotation).number;
            UIImage *flagImage = [UIImage imageNamed:@"PinBackground0_unseleted.png"];
            annotationView.image = flagImage;
            UILabel * label =[[UILabel alloc] initWithFrame:CGRectMake([number length]==1?11:7, -6, annotationView.frame.size.width, annotationView.frame.size.height)];
            label.text = number;
            label.textAlignment=UITextAlignmentLeft;
            label.textColor =[UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:12];
            label.backgroundColor =[UIColor clearColor];
            [annotationView addSubview:label];
            
            UIButton * leftImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            leftImageBtn.frame = CGRectMake(0, 0, 32, 32);
            [leftImageBtn setBackgroundImage: ((ScenicAnnotation *) annotation).image forState:UIControlStateNormal];
            leftImageBtn.tag = ((ScenicAnnotation *) annotation).ID ;
            [leftImageBtn addTarget:self
                             action:@selector(showDetails:)
                   forControlEvents:UIControlEventTouchUpInside];
            annotationView.leftCalloutAccessoryView = leftImageBtn;
            
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
            rightButton.frame = CGRectMake(0, 0, 32, 32);
            [rightButton setBackgroundImage:[UIImage imageNamed:@"prompt_detail.png"] forState:UIControlStateNormal];
           
            rightButton.tag = ((ScenicAnnotation *) annotation).ID ;
            [rightButton addTarget:self
                            action:@selector(showDetails:)
                  forControlEvents:UIControlEventTouchUpInside];
            annotationView.rightCalloutAccessoryView = rightButton;
            annotationView.opaque = NO;
            return annotationView;
        }
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)theMapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [theMapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
}
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
     [self zoomMapViewToFitAnnotationsAnimated:YES];
}
- (void)zoomMapViewToFitAnnotationsAnimated:(BOOL)animated
{
    NSArray *annotations = mapView.annotations;
    int count = [mapView.annotations count];
    if ( count == 0) { return; } //bail if no annotations
    
    //convert NSArray of id <MKAnnotation> into an MKCoordinateRegion that can be used to set the map size
    //can't use NSArray with MKMapPoint because MKMapPoint is not an id
    MKMapPoint points[count]; //C array of MKMapPoint struct
    for( int i=0; i<count; i++ ) //load points C array by converting coordinates to points
    {
        CLLocationCoordinate2D coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        points[i] = MKMapPointForCoordinate(coordinate);
    }
    //create MKMapRect from array of MKMapPoint
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
    //convert MKCoordinateRegion from MKMapRect
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    
    //add padding so pins aren't scrunched on the edges
    region.span.latitudeDelta  *= ANNOTATION_REGION_PAD_FACTOR;
    region.span.longitudeDelta *= ANNOTATION_REGION_PAD_FACTOR;
    //but padding can't be bigger than the world
    if( region.span.latitudeDelta > MAX_DEGREES_ARC ) { region.span.latitudeDelta  = MAX_DEGREES_ARC; }
    if( region.span.longitudeDelta > MAX_DEGREES_ARC ){ region.span.longitudeDelta = MAX_DEGREES_ARC; }
    
    //and don't zoom in stupid-close on small samples
    if( region.span.latitudeDelta  < MINIMUM_ZOOM_ARC ) { region.span.latitudeDelta  = MINIMUM_ZOOM_ARC; }
    if( region.span.longitudeDelta < MINIMUM_ZOOM_ARC ) { region.span.longitudeDelta = MINIMUM_ZOOM_ARC; }
    //and if there is a sample of 1 we want the max zoom-in instead of max zoom-out
    if( count == 1 )
    {
        region.span.latitudeDelta = MINIMUM_ZOOM_ARC;
        region.span.longitudeDelta = MINIMUM_ZOOM_ARC;
    }
    [mapView setRegion:region animated:animated];
}
@end
