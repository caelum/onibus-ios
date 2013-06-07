//
//  LegendaOnibus.h
//  BusaoSP
//
//  Created by Erich Egert on 6/4/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Onibus.h"

@interface LegendaOnibus : UIScrollView

-(id) initWithOnibuses: (NSArray*) onibuses andImagens:(NSArray*) imagemsVeiculos  andLargura: (float) width;

@end
