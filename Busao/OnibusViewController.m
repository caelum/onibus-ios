//
//  OnibusViewController.m
//  BusaoSP
//
//  Created by Erich Egert on 10/19/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "OnibusViewController.h"
#import "Onibus.h"
#import "SSHUDView.h"
#import "ParadasViewController.h"
#import "Ponto.h"

@interface OnibusViewController () {
    Onibus* onibus;
    SSHUDView *loading;
}
@end

@implementation OnibusViewController

@synthesize letreiro;
@synthesize sentido;
@synthesize operacaoDiaUtil;
@synthesize operacaoSabado;
@synthesize operacaoDomingo;
@synthesize paradasDataSource;

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
    
    self.paradasDataSource = [[ParadaDataSource alloc] initWithDelegate:self];
    
}

- (void) recebeParadas: (NSArray *) paradas paraOnibus: (Onibus *) _onibus {
    [loading completeQuicklyWithTitle:NSLocalized(@"pronto")];
    
    
    ParadasViewController *paradasController = [[ParadasViewController alloc]
                                                initWithParadas:paradas
                                                doOnibus:onibus
                                                paraLocalizacao:onibus.ponto.localizacao];
    
    [self.navigationController pushViewController:paradasController animated:YES];
}
- (void) problemaParaBuscarParadas {
    [loading failQuicklyWithTitle:NSLocalized(@"problema_buscando_paradas")];
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
    loading = [[SSHUDView alloc] initWithTitle:NSLocalized(@"buscando_paradas")];
    [loading show];

    [paradasDataSource buscaParadasParaOnibus:onibus];
}
@end
