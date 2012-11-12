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
#import "OnibusDataSource.h"
#import "AppDelegate.h"
#import "Appirater.h"

@interface AppDelegate()

@property(nonatomic, strong) ListaPontoDeOnibusController *listaDeOnibus;
@property(nonatomic, strong) PontosPorProximidadeController *onibusDisponiveis;

@end

@implementation AppDelegate
@synthesize listaDeOnibus, onibusDisponiveis;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    listaDeOnibus = [[ListaPontoDeOnibusController alloc] init];
    onibusDisponiveis = [[PontosPorProximidadeController alloc] init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects:[listaDeOnibus comNavigation], [onibusDisponiveis comNavigation], nil];
       
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];

    [Appirater appLaunched:YES];
    return YES;
}
-(void)applicationWillEnterForeground:(UIApplication *)application{
    [Appirater appEnteredForeground:YES];
}
@end
