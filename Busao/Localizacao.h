//
//  Localizacao.h
//  Busao
//
//  Created by Diego Chohfi on 4/2/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
@interface Localizacao : NSObject <MKAnnotation>

@property(nonatomic, readonly) float latitude;
@property(nonatomic, readonly) float longitude;

- (id)initWithLatitude: (double) latitude eLongitude: (double) longitude;
- (double) distanciaEntrePonto: (Localizacao *) localizacao;

@end
