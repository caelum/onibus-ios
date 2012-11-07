//
//  ParadaDataSource.m
//  Busao
//
//  Created by Diego Chohfi on 3/30/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "ParadaDataSource.h"
#import "Parada.h"
#import "DCKeyValueObjectMapping.h"

@interface ParadaDataSource()

@property(nonatomic, unsafe_unretained) id<ParadasDelegate> delegate;
@property(nonatomic, strong) Onibus *onibus;
@property(nonatomic, strong) DataSource *dataSource;

@end

@implementation ParadaDataSource
@synthesize delegate, onibus, dataSource;

#define URL @"http://ondeestaoalbi2.herokuapp.com/itinerarioDoOnibus.json?onibus=%i"

- (id)initWithDelegate: (id<ParadasDelegate>) _delegate{
    self = [super init];
    if (self) {
        self.delegate = _delegate;
        self.dataSource = [[DataSource alloc] initWithDelegate:self];
    }
    return self;
}

- (void) buscaParadasParaOnibus: (Onibus *) _onibus{
    self.onibus = _onibus;
    [self.dataSource inicializaConexao];
}

-(NSString *)getURL{
    NSString *url = [NSString stringWithFormat:URL, onibus.identificador];
    return url;
}
- (void) tratarRetorno: (NSMutableArray *) dados{    
    DCParserConfiguration *config = [DCParserConfiguration configuration];
    
    DCObjectMapping *codigoToNome = [DCObjectMapping mapKeyPath:@"nome" toAttribute:@"codigo" onClass:[Parada class]];
    [config addObjectMapping:codigoToNome];
    
    DCObjectMapping *coordenadaToLocalizacao = [DCObjectMapping mapKeyPath:@"coordenada" toAttribute:@"localizacao" onClass:[Parada class]];
    [config addObjectMapping:coordenadaToLocalizacao];
    
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[Parada class] andConfiguration:config];
    
    NSArray *paradas = [parser parseArray:dados];
    
    [self.delegate recebeParadas:paradas paraOnibus:self.onibus];    
}
- (void) problemaComunicacao{
    [self.delegate problemaParaBuscarParadas];
}
@end
