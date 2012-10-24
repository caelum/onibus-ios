//
//  Veiculo.h
//  BusaoSP
//
//  Created by Erich Egert on 10/23/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Localizacao.h"

@interface Veiculo : NSObject <MKAnnotation>

@property(nonatomic, strong) Localizacao* localizacao;
@property(nonatomic) int deficentes;

@end
