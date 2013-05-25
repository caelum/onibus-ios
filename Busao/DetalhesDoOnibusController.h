//
//  DetalhesDoOnibusController.h
//  BusaoSP
//
//  Created by Erich Egert on 5/24/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Onibus.h"
#import "ParadaDataSource.h"
#import "TempoRealDataSource.h"
#import "Localizacao.h"

@interface DetalhesDoOnibusController : UIViewController <MKMapViewDelegate,ParadasDelegate, TempoRealDelegate>

- (id)initWithOnibus: (Onibus*) onibus andLocalizacao: (Localizacao*) localizacao;

@end
