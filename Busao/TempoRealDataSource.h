//
//  TempoRealDataSource.h
//  BusaoSP
//
//  Created by Erich Egert on 10/23/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Onibus.h"
#import "DataSource.h"

@protocol TempoRealDelegate <NSObject>

- (void) recebeLocalizacoes: (NSArray *) localizacoes paraOnibus: (Onibus *) onibus;
- (void) problemaParaBuscarLocalizacoes;

@end


@interface TempoRealDataSource : NSObject <DataSourceDelegate>

- (id)initWithDelegate: (id<TempoRealDelegate>) _delegate;

- (void) buscaLocalizacoesParaOnibus: (Onibus *) _onibus;

@end
