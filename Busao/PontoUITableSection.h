//
//  PontoUITableSection.h
//  BusaoSP
//
//  Created by Erich Egert on 6/5/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ponto.h"
#import "Localizacao.h"


@interface PontoUITableSection : UIView

-(id) initWithPonto: (Ponto*) ponto andLocalizacaoAtual: (Localizacao*) localizacao andCallback: (void (^)(void)) callback;

-(void) executaSelecao;

+(CGFloat) height;

@end
