//
//  AppDelegate.h
//  Busao
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Localizacao.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic, strong) Localizacao *localizacaoAtual;

- (void)saveContext;

@end
