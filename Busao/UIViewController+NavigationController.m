//
//  UIViewController+NavigationController.m
//  Busao
//
//  Created by Diego Chohfi on 4/3/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "UIViewController+NavigationController.h"

@implementation UIViewController (NavigationController)

- (UINavigationController *) comNavigation{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    return navigationController;
}

@end
