//
//  ListaOnibusController.h
//  Busao
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PontoDeOnibusController.h"
#import "OnibusDataSource.h"
#import "EGORefreshTableHeaderView.h"

@interface ListaPontoDeOnibusController : PontoDeOnibusController <OnibusDelegate, CLLocationManagerDelegate, EGORefreshTableHeaderDelegate>

- (void) applicationDidBecameActive;

@end
