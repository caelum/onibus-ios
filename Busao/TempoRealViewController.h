//
//  TempoRealViewController.h
//  BusaoSP
//
//  Created by Erich Egert on 10/23/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKMapView+ZoomOut.h"
#import "Onibus.h"
#import "Veiculo.h"

@interface TempoRealViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;

-(id)initWithLocalizacoes: (NSArray *) _localizacoes doOnibus: (Onibus *) _onibus;

@end
