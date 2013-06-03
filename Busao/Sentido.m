//
//  Sentido.m
//  BusaoSP
//
//  Created by Erich Egert on 10/17/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "Sentido.h"

@implementation Sentido

@synthesize terminalPartida, terminalSecundario, circular;

-(NSString *)description{
    return [NSString stringWithFormat:@"%@", terminalPartida];
}

@end
