//
//  Operacao.m
//  BusaoSP
//
//  Created by Erich Egert on 10/17/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "Operacao.h"

@interface Operacao()

-(NSString*) extraiHorario: (NSString*) _horario;

@end


@implementation Operacao

@synthesize diaUtil, domingo, sabado;

-(NSString *) horarioDiaUtil {
    return [self extraiHorario: diaUtil];
}

-(NSString *) horarioSabado {
    return [self extraiHorario: sabado];
}

-(NSString *) horarioDomingo {
    return [self extraiHorario: domingo];
}

-(NSString*) extraiHorario: (NSString*) _horario {
    NSArray *split =[_horario componentsSeparatedByString:@" - "];
    
    if ([split count] == 1 ) {
        return _horario;
    }
    return [split objectAtIndex:1];
}


@end
