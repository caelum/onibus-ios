//
//  AppDelegate.m
//  ;
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "UIViewController+NavigationController.h"
#import "ListaPontoDeOnibusController.h"
#import "PontosPorProximidadeController.h"
#import "OnibusViewController.h"
#import "OnibusDataSource.h"
#import "AppDelegate.h"
#import "Appirater.h"

@interface AppDelegate()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if([UIDevice iPhone]){
        [self configuraViewParaIPhone];
    }else{
        [self configuraViewParaIPad];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [Appirater appLaunched:YES];
    return YES;
}
- (void) configuraViewParaIPad {
    UISplitViewController *splitView = [[UISplitViewController alloc] init];
    ListaPontoDeOnibusController *listaDeOnibus = [[ListaPontoDeOnibusController alloc] init];
    OnibusViewController *onibusViewController = [[OnibusViewController alloc] init];
    listaDeOnibus.onibusController = onibusViewController;
    
    splitView.delegate = onibusViewController;
    
    splitView.viewControllers = @[[listaDeOnibus comNavigation], [onibusViewController comNavigation]];
    
    splitView.tabBarItem = listaDeOnibus.tabBarItem;
    
    PontosPorProximidadeController *onibusDisponiveis = [[PontosPorProximidadeController alloc] init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[splitView, [onibusDisponiveis comNavigation]];
    
    self.window.rootViewController = tabBarController;
}
- (void) configuraViewParaIPhone {
    ListaPontoDeOnibusController *listaDeOnibus = [[ListaPontoDeOnibusController alloc] init];
    PontosPorProximidadeController *onibusDisponiveis = [[PontosPorProximidadeController alloc] init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[[listaDeOnibus comNavigation], [onibusDisponiveis comNavigation]];
    self.window.rootViewController = tabBarController;
}

-(void)applicationWillEnterForeground:(UIApplication *)application{
    [Appirater appEnteredForeground:YES];
}
@end
