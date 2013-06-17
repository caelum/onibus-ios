//
//  OnibusTableCell.h
//  BusaoSP
//
//  Created by Erich Egert on 6/16/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Onibus.h"


@protocol OnibusTableCellDelagate <NSObject>

- (void)favorita:(UIGestureRecognizer *)gestureRecognizer;

@end

@interface OnibusTableCell : UITableViewCell

+(NSString*) identifier;

- (id)initWithOnibus: (Onibus*) onibus andDelegate: (id<OnibusTableCellDelagate>) delegate;

+(UIColor*) corLinhaSelecionada;

-(void) aplicaCorDaCelulaParaOnibusSelecionados: (NSArray*) onibusSelecionados;

@end
