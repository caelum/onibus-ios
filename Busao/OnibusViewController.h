//
//  OnibusViewController.h
//  BusaoSP
//
//  Created by Erich Egert on 10/19/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Onibus.h"
#import "ParadaDataSource.h"
#import "TempoRealDataSource.h"


@interface OnibusViewController : UIViewController <UISplitViewControllerDelegate, ParadasDelegate, TempoRealDelegate>

- (void) setOnibus: (Onibus *) onibus;
- (void) configuraViewParaOnibus: (Onibus *) onibus;


@end
