//
//  Onibus.m
//  Busao
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "Onibus.h"
#import "Ponto.h"

@implementation Onibus
@synthesize nome, linha, paradas, identificador, ponto;

-(NSString *)description{
    return [NSString stringWithFormat:@"%@: %@ - %@", identificador, linha, nome];
}

@end
