//
//  ParadasViewController.h
//  Busao
//
//  Created by Diego Chohfi on 3/30/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "OnibusDataSource.h"
#import "Localizacao.h"
#import "Onibus.h"
@interface ParadasViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;

-(id)initWithParadas: (NSArray *) paradas doOnibus: (Onibus *) ponibus paraLocalizacao: (Localizacao *)localizacao;

@end
