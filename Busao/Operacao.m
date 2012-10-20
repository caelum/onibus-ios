//
//  Operacao.m
//  BusaoSP
//
//  Created by Erich Egert on 10/17/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "Operacao.h"


@implementation Operacao

@synthesize diaUtil, domingo, sabado;

-(NSString *) horarioDiaUtil {
    NSArray *split =[diaUtil componentsSeparatedByString:@" - "];
    
    if ([split count] == 1 ) {
        return diaUtil;
    }
    return [split objectAtIndex:1];

}

-(NSString *) horarioSabado {
    NSArray *split =[sabado componentsSeparatedByString:@" - "];
    
    if ([split count] == 1 ) {
        return sabado;
    }
    return [split objectAtIndex:1];
}

-(NSString *) horarioDomingo {
    NSArray *split =[domingo componentsSeparatedByString:@" - "];
    
    if ([split count] == 1 ) {
        return domingo;
    }
    return [split objectAtIndex:1];
}


@end
