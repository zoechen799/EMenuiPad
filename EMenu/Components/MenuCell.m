//
//  MenuCell.m
//  EMenu
//
//  Created by Chen, Jonny on 11/29/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "MenuCell.h"
#import "OrderHelper.h"
#import "AppConstants.h"
#define MENUCELLWIDTH 250
#define MENUCELLHEIGHT 320

@implementation MenuCell
@synthesize imageurl;
@synthesize quantity;
@synthesize dish;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)loadData
{
	self.backgroundColor = [UIColor whiteColor];
    if(self.imageurl==nil)
        return;
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.imageurl]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    dishImage =[[AsyncImageView alloc] initWithFrame:CGRectMake(2,2, MENUCELLWIDTH -4, MENUCELLWIDTH -4)];
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:dishImage];
    ((AsyncImageView *)dishImage).imageURL = [NSURL URLWithString:self.imageurl];
    dishImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:dishImage];
    
    UIControl * maskForClick =[[UIControl alloc] initWithFrame:CGRectMake(2,2, MENUCELLWIDTH -4, MENUCELLWIDTH -4)];
    maskForClick.backgroundColor =[UIColor clearColor];
    [maskForClick addTarget:self action:@selector(onImageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:maskForClick];
    [maskForClick release];
    
    dishName = [[UILabel alloc] init];
    dishName.frame = CGRectMake(5, 255, 130, 32);
    dishName.backgroundColor =[UIColor clearColor];
    dishName.text = self.dish.name;
    dishName.textColor = [UIColor blackColor];
    dishName.font =[UIFont fontWithName:@"Helvetica" size:16];
    dishName.textAlignment = NSTextAlignmentLeft;
    [self addSubview:dishName];
    
    dishPrice = [[UILabel alloc] init];
    dishPrice.frame = CGRectMake(180, 255, 70, 32);
    dishPrice.backgroundColor =[UIColor clearColor];
    dishPrice.text = [NSString stringWithFormat:@"%.2f元",self.dish.price];
    dishPrice.textColor = [UIColor blackColor];
    dishPrice.font =[UIFont fontWithName:@"Helvetica" size:16];
    dishPrice.textAlignment = NSTextAlignmentLeft;
    [self addSubview:dishPrice];
    
    addBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addBtn.frame = CGRectMake(70, 285, 90, 32);
    addBtn.tintColor = [UIColor lightGrayColor];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:19];
    [addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(onAddClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    
    cancelBtn= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(5, 285, 50, 32);
    [cancelBtn setTitle:@"-" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(onCancelClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    dishAmount =[[UILabel alloc] init];
    dishAmount.frame = CGRectMake(170, 285, 80, 32);
    dishAmount.backgroundColor =[UIColor clearColor];
    dishAmount.text = @"已点0份";
    dishAmount.textColor = [UIColor blackColor];
    dishAmount.font =[UIFont fontWithName:@"Helvetica" size:16];
    dishAmount.textAlignment = NSTextAlignmentLeft;
    [self addSubview:dishAmount];
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
-(void)onImageClicked:(id)sender
{
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    if(dishImage.image!=nil)
        [params setObject:dishImage.image forKey:@"readyImage"];
    [params setObject:self.imageurl forKey:@"imageurl"];
    [params setObject:self.dish forKey:@"dish"];
    [params setObject:[NSNumber numberWithInt:self.quantity] forKey:@"quantity"];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SHOWDETAIL object:self userInfo:params];
}
@end
