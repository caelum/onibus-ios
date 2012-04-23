//
//  Onibus.h
//  Busao
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ponto;
@interface Onibus : NSObject

@property(nonatomic, readonly) long identificador;
@property(nonatomic, readonly) NSString *nome;
@property(nonatomic, readonly) NSString *linha;
@property(nonatomic, strong) Ponto *ponto;
@property(nonatomic, strong) NSArray *paradas;

@end
