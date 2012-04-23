//
//  AnnotationViewFactorie.m
//  Busao
//
//  Created by Diego Chohfi on 4/4/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "AnnotationViewFactory.h"
#import "Localizacao.h"
#import "Parada.h"
#import "Ponto.h"
@implementation AnnotationViewFactory

static NSString *identifier = @"view";

+ (MKAnnotationView *) createViewForAnnotation: (id<MKAnnotation>) annotation inMapView: (MKMapView *) mapView {
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *annotationView = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    } else {
        annotationView.annotation = annotation;
    }
    annotationView.enabled = YES;
    annotationView.selected = NO;
    annotationView.rightCalloutAccessoryView = nil;
    annotationView.canShowCallout = YES;
    if([annotation isKindOfClass:[Localizacao class]]){
        annotationView.canShowCallout = NO;
        annotationView.image = [UIImage imageNamed:@"pin-current.png"];
    }else if([annotation isKindOfClass:[Ponto class]]){
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = infoButton;
        annotationView.image = [UIImage imageNamed:@"pin-busstop.png"];
    }else if([annotation isKindOfClass:[Parada class]]){
        annotationView.image = [UIImage imageNamed:@"pin-bus.png"];
    }
    
    return annotationView;
}
@end
