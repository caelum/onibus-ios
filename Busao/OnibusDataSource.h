//
//  OnibusDataSource.h
//  Busao
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"
#import "Localizacao.h"

@protocol OnibusDelegate <NSObject>

- (void) recebePontos: (NSArray *) pontos paraLocalizacao: (Localizacao *) localizacao;
- (void) problemaParaBuscarPontos;

@end

@interface OnibusDataSource : NSObject <DataSourceDelegate>

- (id)initWithDelegate: (id<OnibusDelegate>) delegate;

- (void) buscaPontosParaLocalizacao: (Localizacao *) localizacao;

@end
