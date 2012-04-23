//
//  Ponto.h
//  Busao
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "Localizacao.h"
#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface Ponto : NSObject <MKAnnotation>

@property(nonatomic, readonly) long identificador;
@property(nonatomic, readonly) NSString *nome;
@property(nonatomic, readonly) NSString *descricao;
@property(nonatomic, readonly) NSArray *onibuses;
@property(nonatomic, readonly) Localizacao *localizacao;

@end
