//
//  SplitViewControllerRotating.m
//  EMenu
//
//  Created by Chen, Jonny on 11/29/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "SplitViewControllerRotating.h"

@interface SplitViewControllerRotating ()

@end

@implementation SplitViewControllerRotating

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}
-(BOOL)shouldAutorotate
{
    return YES;
}
@end
