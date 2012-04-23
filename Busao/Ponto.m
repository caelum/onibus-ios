//
//  Ponto.m
//  Busao
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "Ponto.h"
#import "Onibus.h"
#import <KeyValueObjectMapping/DCKeyValueObjectMapping.h>


@implementation Ponto
@synthesize nome, localizacao, onibuses, descricao, identificador;

- (NSString *)description{
    return [NSString stringWithFormat:@"%@ - %@", nome, [localizacao description]];
}

- (CLLocationCoordinate2D)coordinate{
    return localizacao.coordinate;
}

- (NSString *)title{
    return descricao;
}

- (NSString *)subtitle{
    return [NSString stringWithFormat:@"%i %@", [onibuses count], NSLocalized(@"onibus_no_ponto")];
}

@end
