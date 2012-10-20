//
//  OnibusController.h
//  Busao
//
//  Created by Diego Chohfi on 4/4/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParadaDataSource.h"
#import "Ponto.h"
@interface PontoDeOnibusController : UITableViewController <UISearchDisplayDelegate>

@property(nonatomic, strong) Localizacao *localizacaoAtual;
@property(nonatomic, strong) NSArray *pontos;

- (id)initWithPonto: (Ponto *) ponto;
- (BOOL) isSearching:(UITableView *)tableView;
@end
