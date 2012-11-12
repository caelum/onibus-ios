//
//  OnibusController.h
//  Busao
//
//  Created by Diego Chohfi on 4/4/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ponto, ParadaDataSource, OnibusViewController, Localizacao;

@interface PontoDeOnibusController : UITableViewController <UISearchDisplayDelegate>

@property(nonatomic, strong) Localizacao *localizacaoAtual;
@property(nonatomic, strong) NSArray *pontos;
@property(nonatomic, strong) OnibusViewController *onibusController;

- (id)initWithPonto: (Ponto *) ponto;
- (BOOL) isSearching:(UITableView *)tableView;
@end
