//
//  OrderListCell.m
//  EMenu
//
//  Created by Chen, Jonny on 11/30/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "OrderListCell.h"
#import "OrderHelper.h"
#import <QuartzCore/QuartzCore.h>
@implementation OrderListCell

-(void)dealloc
{
    [nameLabel release];
    [priceLabel release];
    [quantityLabel release];
    [_dish release];
    [addBtn release];
    [cancelBtn release];
    [super dealloc];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bg = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 700, 45)];
        bg.backgroundColor = [UIColor clearColor];
        self.backgroundView = bg;

        nameLabel =[[UILabel alloc] init];
        nameLabel.frame = CGRectMake(10, 5, 200, 32);
        nameLabel.backgroundColor =[UIColor clearColor];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font =[UIFont fontWithName:@"Helvetica" size:19];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:nameLabel];
        [nameLabel release];
        
        priceLabel =[[UILabel alloc] init];
        priceLabel.frame = CGRectMake(210, 5, 100, 32);
        priceLabel.backgroundColor =[UIColor clearColor];
        priceLabel.textColor = [UIColor redColor];
        priceLabel.font =[UIFont fontWithName:@"Helvetica" size:19];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:priceLabel];
        [priceLabel release];
        
        quantityLabel =[[UILabel alloc] init];
        quantityLabel.frame = CGRectMake(310, 5, 100, 32);
        quantityLabel.backgroundColor =[UIColor clearColor];
        quantityLabel.textColor = [UIColor whiteColor];
        quantityLabel.text = @"0份"; 
        quantityLabel.font =[UIFont fontWithName:@"Helvetica" size:19];
        quantityLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:quantityLabel];
        
        addBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        addBtn.frame = CGRectMake(370, 5, 90, 32);
        addBtn.tintColor = [UIColor lightGrayColor];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:19];
        [addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(onAddClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addBtn];
        
        cancelBtn= [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelBtn.frame = CGRectMake(478, 5, 50, 32);
        [cancelBtn setTitle:@"-" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(onCancelClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        totalPriceLabel =[[UILabel alloc] init];
        totalPriceLabel.frame = CGRectMake(595, 5, 100, 32);
        totalPriceLabel.backgroundColor =[UIColor clearColor];
        totalPriceLabel.textColor = [UIColor whiteColor];
        totalPriceLabel.font =[UIFont fontWithName:@"Helvetica" size:19];
        totalPriceLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:totalPriceLabel];
        
        UIView * sep1 = [[UIView alloc] initWithFrame:CGRectMake(160, 12, 1, 19)];
        sep1.backgroundColor =[UIColor grayColor];
        sep1.layer.shadowColor = [[UIColor grayColor] CGColor];
        sep1.layer.shadowOffset = CGSizeMake(1.0f,0.0f);
        sep1.layer.shadowOpacity = .5f;
        sep1.layer.shadowRadius = 1.0f;
        [self addSubview:sep1];
        [sep1 release];
        
        UIView * sep2 = [[UIView alloc] initWithFrame:CGRectMake(275, 12, 1, 19)];
        sep2.backgroundColor =[UIColor grayColor];
        sep2.layer.shadowColor = [[UIColor grayColor] CGColor];
        sep2.layer.shadowOffset = CGSizeMake(1.0f,0.0f);
        sep2.layer.shadowOpacity = .5f;
        sep2.layer.shadowRadius = 1.0f;
        [self addSubview:sep2];
        [sep2 release];
        
        UIView * sep3 = [[UIView alloc] initWithFrame:CGRectMake(590, 12, 1, 19)];
        sep3.backgroundColor =[UIColor grayColor];
        sep3.layer.shadowColor = [[UIColor grayColor] CGColor];
        sep3.layer.shadowOffset = CGSizeMake(1.0f,0.0f);
        sep3.layer.shadowOpacity = .5f;
        sep3.layer.shadowRadius = 1.0f;
        [self addSubview:sep3];
        [sep3 release];
    }
    return self;
}
-(void)setDish:(Dish *)newdish
{
    _dish = newdish;
    nameLabel.text = newdish.name;
    priceLabel.text =[NSString stringWithFormat:@"%.2f元",newdish.price];
    if(self.dishQuantity!=0)
        totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元", newdish.price * self.dishQuantity];
}
-(Dish*)dish
{
    return _dish;
}
-(void)setDishQuantity:(int)qty
{
    _qty =qty;
    quantityLabel.text = [NSString stringWithFormat:@"%d份", qty];
    if(self.dish !=nil)
        totalPriceLabel.text = [NSString stringWithFormat:@"%.2f元", self.dish.price * qty];
}
-(int)dishQuantity
{
    return _qty;
}
-(void)onAddClicked:(id)sender
{
    self.dishQuantity ++;
    quantityLabel.text = [NSString stringWithFormat:@"%d份", self.dishQuantity];
    [[OrderHelper sharedOrderHelper]addDish:self.dish];
}
-(void) onCancelClicked:(id)sender
{
    if(self.dishQuantity>0){
        self.dishQuantity--;
        [[OrderHelper sharedOrderHelper]removeDish:self.dish];
    }
    quantityLabel.text = [NSString stringWithFormat:@"%d", self.dishQuantity];
}
@end
