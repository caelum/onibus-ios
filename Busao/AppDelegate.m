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
@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

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
   
    //TODO
    
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

-(void) applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(void)applicationWillEnterForeground:(UIApplication *)application{
    [Appirater appEnteredForeground:YES];
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BusaoSP" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BusaoSP.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
