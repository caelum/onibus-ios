//
//  Onibus.h
//  Busao
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sentido.h"
#import "Operacao.h"

@class Ponto;
@interface Onibus : NSObject

@property(nonatomic, readonly) int identificador;
@property(nonatomic, readonly) NSString *letreiro;
@property(nonatomic, readonly) NSString *codigoGPS;
@property(nonatomic, strong) Sentido *sentido;
@property(nonatomic, strong) Operacao *operacao;
@property(nonatomic, strong) Ponto *ponto;
@property(nonatomic, strong) NSArray *paradas;

@end
