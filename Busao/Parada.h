//
//  Parada.h
//  Busao
//
//  Created by Diego Chohfi on 3/30/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "Localizacao.h"
#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface Parada : NSObject <MKAnnotation>

@property(nonatomic, readonly) NSString *codigo;
@property(nonatomic, readonly) NSString *descricao;
@property(nonatomic, readonly) Localizacao *localizacao;

@end