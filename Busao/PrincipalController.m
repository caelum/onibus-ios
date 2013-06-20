//
//  PrincipalController.m
//  BusaoSP
//
//  Created by Erich Egert on 6/20/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "PrincipalController.h"
#import "ListaPontoDeOnibusController.h"
#import "MenuNavegacaoController.h"

@implementation PrincipalController


-(id) init {
    if (self = [super init]) {
        self.shouldDelegateAutorotateToVisiblePanel = NO;
        self.navigationItem.leftBarButtonItem = [self leftButtonForCenterPanel];
        
        MenuNavegacaoController *menu = [MenuNavegacaoController new];
        self.leftPanel = menu;
        
        [self trocaCenterPanel:[menu defaultCenterPanelController]];
        
        PrincipalController *_self = self;
        [menu setContollerSelecionadoCallback:^(UIViewController * controller) {
            [_self trocaCenterPanel:controller];
        }];
        
    }
    return self;
}

-(void) trocaCenterPanel: (UIViewController*) controller {
    self.centerPanel = controller;
    self.navigationItem.rightBarButtonItems = self.centerPanel.navigationItem.rightBarButtonItems;
    self.navigationItem.title = self.centerPanel.title;

}

@end
