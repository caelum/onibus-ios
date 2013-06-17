 //
//  OnibusController.h
//  Busao
//
//  Created by Diego Chohfi on 4/4/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnibusTableCell.h"

@class Ponto, ParadaDataSource, OnibusViewController, Localizacao;

@interface PontoDeOnibusController : UITableViewController <UISearchDisplayDelegate, OnibusTableCellDelagate>

@property(nonatomic, strong) Localizacao *localizacaoAtual;
@property(nonatomic, strong) NSArray *pontos;
@property(nonatomic, strong) OnibusViewController *onibusController;
@property(nonatomic, strong) NSMutableArray *pontosSelecionados;
@property(nonatomic, strong) NSMutableArray *onibusSelecionados;

- (id)initWithPonto: (Ponto *) ponto;
- (BOOL) isSearching:(UITableView *)tableView;

-(void) irParaMapa;
@end
