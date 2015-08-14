//
//  DishDetailViewController.m
//  EMenu
//
//  Created by Chen, Jonny on 12/1/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "DishDetailViewController.h"
#import "OrderHelper.h"

@implementation DishDetailViewController
@synthesize imageurl;
@synthesize quantity;
@synthesize dish;
@synthesize readyImage;
@synthesize restaurant;
@synthesize appCallback;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg2.jpg"]];
    self.view.backgroundColor =[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg3.png"]];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回菜单" style:UIBarButtonItemStylePlain target:self action:@selector(onBackButtonClicked:)];
    [backBtn setTitle:@"返回菜单"];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem =backBtn;
    [self loadData];
}

- (void)viewWillLayoutSubviews
{
    panel.frame = CGRectMake(10, self.view.frame.size.height-70, self.view.frame.size.width-20, 50);
    if(dishImage!=nil)
        dishImage.frame = CGRectMake(10,10, self.view.frame.size.width -300, self.view.frame.size.height -100);
}
-(void)onBackButtonClicked:(id)sender
{
    if(appCallback!=nil && self.restaurant!=nil)
        [appCallback backToMenu:self.restaurant];
}
- (void)loadData
{
    panel =[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height-70, self.view.frame.size.width-20, 50)];
    panel.backgroundColor =[UIColor clearColor];
    
    dishName = [[UILabel alloc] init];
    dishName.frame = CGRectMake(5, 15, 130, 32);
    dishName.backgroundColor =[UIColor clearColor];
    dishName.text = self.dish.name;
    dishName.textColor = [UIColor blackColor];
    dishName.font =[UIFont fontWithName:@"Helvetica" size:16];
    dishName.textAlignment = NSTextAlignmentLeft;
    [panel addSubview:dishName];
    
    dishPrice = [[UILabel alloc] init];
    dishPrice.frame = CGRectMake(180, 15, 70, 32);
    dishPrice.backgroundColor =[UIColor clearColor];
    dishPrice.text = [NSString stringWithFormat:@"%.2f元",self.dish.price];
    dishPrice.textColor = [UIColor blackColor];
    dishPrice.font =[UIFont fontWithName:@"Helvetica" size:16];
    dishPrice.textAlignment = NSTextAlignmentLeft;
    [panel addSubview:dishPrice];
    
    addBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addBtn.frame = CGRectMake(260, 15, 90, 32);
    addBtn.tintColor = [UIColor lightGrayColor];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:19];
    [addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(onAddClicked:) forControlEvents:UIControlEventTouchUpInside];
    [panel addSubview:addBtn];
    
    cancelBtn= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(360, 15, 50, 32);
    [cancelBtn setTitle:@"-" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(onCancelClicked:) forControlEvents:UIControlEventTouchUpInside];
    [panel addSubview:cancelBtn];
    
    dishAmount =[[UILabel alloc] init];
    dishAmount.frame = CGRectMake(460, 15, 80, 32);
    dishAmount.backgroundColor =[UIColor clearColor];
    dishAmount.text = @"已点0份";
    dishAmount.textColor = [UIColor blackColor];
    dishAmount.font =[UIFont fontWithName:@"Helvetica" size:16];
    dishAmount.textAlignment = NSTextAlignmentLeft;
    [panel addSubview:dishAmount];
    
    [self.view addSubview:panel];
    if(self.imageurl==nil && self.readyImage==nil)
        return;
    if(self.readyImage!=nil){
        dishImage = [[UIImageView alloc] initWithFrame:CGRectMake(10,10, self.view.frame.size.width -300, self.view.frame.size.height -100)];
        [dishImage setImage:self.readyImage];
        [self.view addSubview:dishImage];
    }else{
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.imageurl]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        
        dishImage =[[AsyncImageView alloc] initWithFrame:CGRectMake(10,10, self.view.frame.size.width -300, self.view.frame.size.height -100)];
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:dishImage];
        ((AsyncImageView *)dishImage).imageURL = [NSURL URLWithString:self.imageurl];
        dishImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:dishImage];
    }
}
-(void) onAddClicked:(id)sender
{
    self.quantity ++;
    dishAmount.text = [NSString stringWithFormat:@"已点%d份", self.quantity];
    [[OrderHelper sharedOrderHelper]addDish:self.dish];
}
-(void) onCancelClicked:(id)sender
{
    if(self.quantity>0){
        self.quantity--;
        [[OrderHelper sharedOrderHelper]removeDish:self.dish];
    }
    dishAmount.text = [NSString stringWithFormat:@"已点%d份", self.quantity];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
