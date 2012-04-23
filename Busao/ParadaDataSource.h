//
//  ParadaDataSource.h
//  Busao
//
//  Created by Diego Chohfi on 3/30/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"
#import "Onibus.h"

@protocol ParadasDelegate <NSObject>

- (void) recebeParadas: (NSArray *) paradas paraOnibus: (Onibus *) onibus;
- (void) problemaParaBuscarParadas;

@end

@interface ParadaDataSource : NSObject <DataSourceDelegate>

- (id)initWithDelegate: (id<ParadasDelegate>) delegate;
- (void)buscaParadasParaOnibus: (Onibus *) onibus;

@end
