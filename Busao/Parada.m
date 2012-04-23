//
//  Parada.m
//  Busao
//
//  Created by Diego Chohfi on 3/30/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "Parada.h"

@implementation Parada
@synthesize codigo, descricao, localizacao;

- (CLLocationCoordinate2D)coordinate{
    return localizacao.coordinate;
}

- (NSString *)title{
    return descricao;
}

- (NSString *)subtitle{
    return @"Parada";
}

@end
