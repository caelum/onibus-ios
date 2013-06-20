//
//  OnibusDisponiveis.h
//  Busao
//
//  Created by Diego Chohfi on 4/3/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "OnibusDataSource.h"

@interface PontosPorProximidadeController : UIViewController <MKMapViewDelegate, OnibusDelegate>

@property (strong, nonatomic) MKMapView *mapView;


@end
