//
//  MenuNavegacaoController.h
//  BusaoSP
//
//  Created by Erich Egert on 6/20/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuNavegacaoController : UITableViewController

@property (nonatomic, strong) void (^contollerSelecionadoCallback) (UIViewController*);

-(UIViewController*) defaultCenterPanelController;

@end
