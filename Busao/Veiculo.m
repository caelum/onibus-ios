//
//  Veiculo.m
//  BusaoSP
//
//  Created by Erich Egert on 10/23/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "Veiculo.h"

@implementation Veiculo

@synthesize deficentes;
@synthesize localizacao;

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    
    if (![super isEqual:other])
        return NO;
    
    return ( [ [self localizacao] isEqual: [other localizacao] ] );
}

-(NSString*) description {
    return [localizacao description];
}

- (CLLocationCoordinate2D)coordinate{
    return localizacao.coordinate;
}

- (NSString *)title{
    return self.letreiro;
}

- (NSString *)subtitle{
    return self.linha;
}

@end
