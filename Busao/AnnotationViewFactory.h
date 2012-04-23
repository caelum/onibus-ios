//
//  AnnotationViewFactorie.h
//  Busao
//
//  Created by Diego Chohfi on 4/4/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface AnnotationViewFactory : NSObject

+ (MKAnnotationView *) createViewForAnnotation: (id<MKAnnotation>) annotation inMapView: (MKMapView *) mapView;

@end
