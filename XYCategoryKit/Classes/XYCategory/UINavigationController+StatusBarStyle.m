//
//  UINavigationController+StatusBarStyle.m
//  BiYong
//
//  Created by baige on 2018/3/25.
//

#import "UINavigationController+StatusBarStyle.h"

@implementation UINavigationController (StatusBarStyle)

- (UIViewController *)childViewControllerForStatusBarStyle{

    return self.visibleViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden{
    
    return self.visibleViewController;
    
}

@end
