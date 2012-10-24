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


@interface OnibusViewController : UIViewController <ParadasDelegate, TempoRealDelegate>

@property (strong, nonatomic) IBOutlet UILabel *letreiro;
@property (strong, nonatomic) IBOutlet UILabel *sentido;
@property (strong, nonatomic) IBOutlet UILabel *operacaoDiaUtil;
@property (strong, nonatomic) IBOutlet UILabel *operacaoSabado;
@property (strong, nonatomic) IBOutlet UILabel *operacaoDomingo;

@property(nonatomic, strong) ParadaDataSource *paradasDataSource;
@property(nonatomic, strong) TempoRealDataSource *tempoRealDataSource;

- (IBAction)mostraPontos:(id)sender;
- (IBAction)mostraLocalizacaoEmTempoReal:(id)sender;

- (id)initWithOnibus: (Onibus*) _onibus;


@end
