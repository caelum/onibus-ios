//
//  MKMapView+ZoomOut.m
//  Busao
//
//  Created by Diego Chohfi on 4/2/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "MKMapView+ZoomOut.h"

@implementation MKMapView (ZoomOut)

- (void)zoomOut {
    if ([self.annotations count] == 0) return; 
    
    CLLocationCoordinate2D topLeftCoord; 
    topLeftCoord.latitude = -90; 
    topLeftCoord.longitude = 180; 
    
    CLLocationCoordinate2D bottomRightCoord; 
    bottomRightCoord.latitude = 90; 
    bottomRightCoord.longitude = -180; 
    
    for(id<MKAnnotation> point in self.annotations) { 
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, point.coordinate.longitude); 
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, point.coordinate.latitude); 
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, point.coordinate.longitude); 
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, point.coordinate.latitude); 
    } 
    
    MKCoordinateRegion region; 
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.6; 
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.6;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.4;
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.4;
        
    region = [self regionThatFits:region]; 
    [self setRegion:region animated:YES];   
}

@end
