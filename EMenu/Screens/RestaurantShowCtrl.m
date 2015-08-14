//
//  RestaurantShowController.m
//  EMenu
//
//  Created by Chen, Jonny on 11/24/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "RestaurantShowCtrl.h"
#import "AsyncImageView.h"

@implementation RestaurantShowCtrl
@synthesize appCallback;
@synthesize restaurant;
-(id)init
{
    [self loadData];
    return [super init];
}
-(void)dealloc
{
    [carousel release];
    carousel = nil;
    [photos release];
    photos = nil;
    [intros release];
    intros =nil;
    [label release];
    label =nil;
    [skipBtn release];
    skipBtn =nil;
    [panel release];
    panel = nil;
    [super dealloc];
}

- (void)viewWillLayoutSubviews{
    carousel.frame = self.view.frame;
    label.frame = CGRectMake(100, 500, self.view.frame.size.width -200, 200);
    skipBtn.frame = CGRectMake(800, 65, 100, 32);
    panel.frame = CGRectMake(100, 500, self.view.frame.size.width -200, 200);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg3.png"]];
    carousel = [[iCarousel alloc] initWithFrame:self.view.frame];
    carousel.type = iCarouselTypeCoverFlow;
    carousel.delegate =self;
    carousel.dataSource =self;
    [self.view addSubview:carousel];
    
    panel =[[UIView alloc]init];
    panel.backgroundColor = [UIColor blackColor];
    [panel.layer setCornerRadius:14];
    panel.alpha = 0.3f;
    panel.frame = CGRectMake(100, 500, self.view.frame.size.width -200, 200);
    [self.view addSubview:panel];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(100, 500, self.view.frame.size.width -200, 200)];
    label.font =[UIFont fontWithName:@"Helvetica" size:30];
    label.textColor =[UIColor whiteColor];
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.numberOfLines =0;
    label.backgroundColor =[UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:label];
    
    skipBtn = [[GradientButton alloc] initWithFrame:CGRectMake(800, 65, 100, 32)];
    [skipBtn useSimpleOrangeStyle];
    [skipBtn setTitle: NSLocalizedString(@"查看菜单", nil) forState:UIControlStateNormal];
    [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    skipBtn.tag =1;
    [skipBtn addTarget:self action:@selector(onMenuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipBtn];
    [skipBtn release];
    
    
}
-(void)loadData
{
    
}
-(void)onMenuButtonClicked:(id)sender
{
    if(appCallback!=nil){
        [appCallback loadSpliterViewController: restaurant aBrandNew:YES];
    }
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [restaurant.pictureUrls count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{    
    if (view == nil || view.tag != index)
    {
        view = [[[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 682)] autorelease];
        view.contentMode = UIViewContentModeScaleAspectFit;
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view];
        ((AsyncImageView *)view).imageURL = [NSURL URLWithString:[restaurant.pictureUrls objectAtIndex:index]];
        view.contentMode = UIViewContentModeCenter;
        view.tag =index;
       
    }
   
    return view;
}
- (void)carouselWillBeginDragging:(iCarousel *)carousel
{
    panel.hidden = YES;
    label.hidden = YES;
}
- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
{
    label.hidden = NO;
    if (aCarousel.currentItemIndex < [restaurant.introductions count]) {
        [label setText:[NSString stringWithFormat:@"%@", [restaurant.introductions objectAtIndex:aCarousel.currentItemIndex]]];
        panel.hidden = NO;
    }else{
        [label setText:@""];
        panel.hidden = YES;
    }
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)aCarousel
{
    if(aCarousel.currentItemIndex == [photos count]-1)
    {
        if(appCallback!=nil){
            [appCallback loadSpliterViewController: restaurant aBrandNew:YES];
        }
    }
}
@end
