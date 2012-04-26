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
@interface PontoDeOnibusController : UITableViewController <ParadasDelegate, UISearchDisplayDelegate>

@property(nonatomic, strong) Localizacao *localizacaoAtual;
@property(nonatomic, strong) NSArray *pontos;
@property(nonatomic, strong) ParadaDataSource *paradasDataSource;
- (id)initWithPonto: (Ponto *) ponto;
- (BOOL) isSearching:(UITableView *)tableView;
@end
