//
//  Localizacao.m
//  Busao
//
//  Created by Diego Chohfi on 4/2/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "Localizacao.h"
#import <CoreLocation/CLLocation.h>
@implementation Localizacao
@synthesize longitude, latitude;

-(id)initWithLatitude: (double) _latitude eLongitude: (double) _longitude {
    self = [super init];
    if (self) {
        latitude = _latitude;
        longitude = _longitude;
    }
    return self;
}

- (double) distanciaEntrePonto: (Localizacao *) localizacao {
    CLLocation *localizacaoDesejada = [[CLLocation alloc] initWithLatitude:localizacao.latitude longitude:localizacao.longitude];
    
    CLLocation *localizacaoAtual = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
    
    CLLocationDistance distancia = [localizacaoAtual distanceFromLocation:localizacaoDesejada];
    return distancia;
}

- (CLLocationCoordinate2D)coordinate{
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%d - %d", latitude, longitude];
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    
    if (![super isEqual:other])
        return NO;
    
    return ([self latitude] == [other latitude] && [self longitude] == [other longitude]);
}

- (NSString *)title{
    return @"Localização atual";
}

- (NSString *)subtitle{
    return @"To aqui!";
}

@end
