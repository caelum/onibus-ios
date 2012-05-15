//
//  OnibusDataSource.m
//  Busao
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "OnibusDataSource.h"
#import "Ponto.h"
#import "Onibus.h"
#import <KeyValueObjectMapping/DCKeyValueObjectMapping.h>

#define URL @"http://ondeestaoalbi.herokuapp.com/onibusesNosPontosProximos.json?lat=%f&long=%f"
@interface OnibusDataSource()

@property(nonatomic, unsafe_unretained) id<OnibusDelegate> delegate;
@property(nonatomic, strong) DataSource *dataSource;
@property(nonatomic, strong) Localizacao *localizacao;

@end

@implementation OnibusDataSource
@synthesize delegate, dataSource, localizacao;

-(id)initWithDelegate: (id<OnibusDelegate>) _delegate {
    self = [super init];
    if (self) {
        self.delegate = _delegate;
        self.dataSource = [[DataSource alloc] initWithDelegate:self];
    }
    return self;
}

- (void) buscaPontosParaLocalizacao: (Localizacao *) _localizacao {
    self.localizacao = _localizacao;
    [self.dataSource inicializaConexao];
}

-(NSString *)getURL {
    NSString *url = [NSString stringWithFormat:URL, localizacao.latitude, localizacao.longitude];
    return url;
}

- (void)tratarRetorno:(NSMutableArray *)dados{
    [delegate recebePontos:[self parseJsonBusao:dados] paraLocalizacao: localizacao];
}
-(void)problemaComunicacao{
    [delegate problemaParaBuscarPontos];
}
- (NSArray *) parseJsonBusao: (NSMutableArray *) resultados{    
    DCParserConfiguration *config = [DCParserConfiguration configuration];
    
    DCArrayMapping *onibues = [DCArrayMapping mapperForClassElements:[Onibus class] forAttribute:@"onibuses" onClass:[Ponto class]];
    [config addArrayMapper:onibues];
    
    DCObjectMapping *coordenada = [DCObjectMapping mapKeyPath:@"coordenada" toAttribute:@"localizacao" onClass:[Ponto class]];
    DCObjectMapping *idPonto = [DCObjectMapping mapKeyPath:@"id" toAttribute:@"identificador" onClass:[Ponto class]];
    DCObjectMapping *idOnibus = [DCObjectMapping mapKeyPath:@"id" toAttribute:@"identificador" onClass:[Onibus class]];
    
    [config addObjectMapping:coordenada];
    [config addObjectMapping:idPonto];
    [config addObjectMapping:idOnibus];
    
    
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[Ponto class] andConfiguration:config];
    return [parser parseArray:resultados];
}
@end
