//
//  RestaurantCell.m
//  EMenu
//
//  Created by Chen, Jonny on 11/26/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "RestaurantCell.h"

@implementation RestaurantCell
@synthesize restaurantName;
@synthesize address;
@synthesize star;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bg = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 250, 120)];
        bg.backgroundColor = [UIColor whiteColor];
        self.backgroundView = bg;
        restaurantName =[[UILabel alloc] init];
        restaurantName.frame = CGRectMake(13, 5, 230, 32);
        restaurantName.backgroundColor =[UIColor clearColor];
        restaurantName.textColor = [UIColor blackColor];
        restaurantName.font =[UIFont fontWithName:@"Helvetica" size:19];
        restaurantName.textAlignment = NSTextAlignmentLeft;
        [self addSubview:restaurantName];
        
        address =[[UILabel alloc] init];
        address.frame = CGRectMake(13, 30, 230, 60);
        address.backgroundColor =[UIColor clearColor];
        address.textColor = [UIColor blackColor];
        address.font =[UIFont fontWithName:@"Helvetica" size:16];
        address.textAlignment = NSTextAlignmentLeft;
        address.numberOfLines =0;
        [self addSubview:address];
        
        star =[[UIStar alloc] init];
        star.frame = CGRectMake(13, 96, 78, 14);
        [self addSubview:star];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    [restaurantName release];
    restaurantName =nil;
    [address release];
    address =nil;
    [star release];
    star =nil;
    [super dealloc];
}
@end
