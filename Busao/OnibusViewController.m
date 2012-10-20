//
//  OnibusViewController.m
//  BusaoSP
//
//  Created by Erich Egert on 10/19/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "OnibusViewController.h"
#import "Onibus.h"

@interface OnibusViewController () {
    Onibus* onibus;
}
@end

@implementation OnibusViewController

@synthesize letreiro;
@synthesize sentido;
@synthesize operacaoDiaUtil;
@synthesize operacaoSabado;
@synthesize operacaoDomingo;

- (id)initWithOnibus: (Onibus*) _onibus
{
    self = [super initWithNibName:@"OnibusViewController"
                           bundle:[NSBundle mainBundle]];
    if (self) {
        onibus = _onibus;
    }
    return self;
}
    

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [letreiro setText:[onibus letreiro]];
    [sentido setText:[[onibus sentido] description ]];
    [operacaoDiaUtil setText: [[onibus operacao] horarioDiaUtil ] ];
    [operacaoSabado setText: [[onibus operacao] horarioSabado ] ];
    [operacaoDomingo setText: [[onibus operacao] horarioDomingo ] ];
    
}

- (void)viewDidUnload
{
    [self setLetreiro:nil];
    [self setSentido:nil];
    [self setOperacaoDiaUtil:nil];
    [self setOperacaoSabado:nil];
    [self setOperacaoDomingo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)mostraPontos:(id)sender {
    
}
@end
