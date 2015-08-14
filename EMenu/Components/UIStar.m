//
//  UIStar.m
//  EMenu
//
//  Created by Chen, Jonny on 11/26/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "UIStar.h"

@implementation UIStar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setStar:(NSUInteger)value
{
    _star = value;
    starImage =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:starImage];
    [starImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ShopStar%d0.png",value]]];
}
-(NSUInteger)star
{
    return _star;
}

@end
