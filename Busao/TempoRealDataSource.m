//
//  TempoRealDataSource.m
//  BusaoSP
//
//  Created by Erich Egert on 10/23/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "TempoRealDataSource.h"
#import "DataSource.h"
#import <KeyValueObjectMapping/DCKeyValueObjectMapping.h>
#import "Veiculo.h"

#define URL @"http://ondeestaoalbi2.herokuapp.com/localizacoesDoOnibus.json?codigoLinha=%@"

@interface TempoRealDataSource()

@property(nonatomic, unsafe_unretained) id<TempoRealDelegate> delegate;
@property(nonatomic, strong) DataSource *dataSource;
@property(nonatomic, strong) Onibus *onibus;

@end

@implementation TempoRealDataSource



- (id)initWithDelegate: (id<TempoRealDelegate>) delegateTempoReal {
    self = [super init];
    if (self) {
        self.delegate = delegateTempoReal;
        self.dataSource = [[DataSource alloc] initWithDelegate:self];
    }
    return self;
    
}

- (void) buscaLocalizacoesParaOnibus: (Onibus *) onibusSelecionado {
    self.onibus = onibusSelecionado;
    [self.dataSource inicializaConexao];
}

- (NSString *) getURL {
    return [NSString stringWithFormat:URL, [self.onibus codigoGPS] ];
}

- (void) tratarRetorno: (NSMutableArray *) dados {
    [self.delegate recebeLocalizacoes: [self parseJsonBusao:dados] paraOnibus: self.onibus ];
}

- (void) problemaComunicacao {
    [self.delegate problemaParaBuscarLocalizacoes];
}

- (NSArray *) parseJsonBusao: (NSMutableArray *) resultados{
    DCParserConfiguration *config = [DCParserConfiguration configuration];
    
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[Veiculo class]
                                                             andConfiguration:config];
    
    return [parser parseArray:resultados];
}


@end
