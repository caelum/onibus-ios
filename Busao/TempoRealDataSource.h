//
//  TempoRealDataSource.h
//  BusaoSP
//
//  Created by Erich Egert on 10/23/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OnibusInfo.h"
#import "DataSource.h"

@protocol TempoRealDelegate <NSObject>

- (void) recebeLocalizacoes: (NSArray *) localizacoes paraOnibus: (id<OnibusInfo>) onibus;
- (void) problemaParaBuscarLocalizacoes;

@end


@interface TempoRealDataSource : NSObject <DataSourceDelegate>

- (id)initWithDelegate: (id<TempoRealDelegate>) _delegate;

- (void) buscaLocalizacoesParaOnibus: (id<OnibusInfo>) onibus;

@end
