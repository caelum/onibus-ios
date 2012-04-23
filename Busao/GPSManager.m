//
//  GPSManager.m
//  BusaoSP
//
//  Created by Diego Chohfi on 4/11/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "GPSManager.h"
#import <CoreLocation/CoreLocation.h>
@implementation GPSManager

+(BOOL) isGPSDisabled {
    BOOL gpsIndisponivel = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || 
    [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted;
    return gpsIndisponivel;
}

@end
