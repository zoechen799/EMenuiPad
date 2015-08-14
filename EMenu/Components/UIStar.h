//
//  UIStar.h
//  EMenu
//
//  Created by Chen, Jonny on 11/26/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStar : UIControl
{
    UIImageView * starImage;
    NSUInteger _star;
}
@property(nonatomic) NSUInteger star;
@end
