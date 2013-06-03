//
//  Veiculo.h
//  BusaoSP
//
//  Created by Erich Egert on 10/23/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Localizacao.h"
#import "Onibus.h"

@interface Veiculo : NSObject <MKAnnotation>

@property(nonatomic, strong) Localizacao* localizacao;
@property(nonatomic) int deficentes;
@property(nonatomic) int onibus;
@property(nonatomic, strong) NSString *linha;
@property(nonatomic, strong) NSString *letreiro;

@end
