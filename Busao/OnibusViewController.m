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
#import "TempoRealViewController.h"
#import "Ponto.h"
#import "UIViewController+AutoOrientation.h"
@interface OnibusViewController () {
    Onibus* onibus;
    SSHUDView *loading;
}
@end

@implementation OnibusViewController

- (id)initWithOnibus: (Onibus*) _onibus
{
    self = [super initWithNibName:@"OnibusViewController"
                           bundle:[NSBundle mainBundle]];
    if (self) {
        onibus = _onibus;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [self changeViewIfOnLandscape:self.interfaceOrientation];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.letreiro setText:[onibus letreiro]];
    [self.sentido setText:[[onibus sentido] description ]];
    [self.operacaoDiaUtil setText: [[onibus operacao] horarioDiaUtil ] ];
    [self.operacaoSabado setText: [[onibus operacao] horarioSabado ] ];
    [self.operacaoDomingo setText: [[onibus operacao] horarioDomingo ] ];
    

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

- (void) recebeLocalizacoes: (NSArray *) localizacoes paraOnibus: (Onibus *) __onibus {
    [loading completeQuicklyWithTitle:NSLocalized(@"pronto")];
    
    if ([localizacoes count] >0) {
        TempoRealViewController *controller = [[TempoRealViewController alloc]
                                               initWithLocalizacoes:localizacoes
                                               doOnibus: __onibus];
        
        [self.navigationController pushViewController:controller animated:YES];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tempo real"
                                                        message:@"Nenhuma veiculo localizado no momento"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    
}
- (void) problemaParaBuscarLocalizacoes {
    [loading failQuicklyWithTitle:@"Problema buscando localizações atuais"];
}

- (void)viewDidUnload
{
    [self setLetreiro:nil];
    [self setSentido:nil];
    [self setOperacaoDiaUtil:nil];
    [self setOperacaoSabado:nil];
    [self setOperacaoDomingo:nil];
    [self setTempoRealDataSource:nil];
    [self setParadasDataSource:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)mostraLocalizacaoEmTempoReal:(id)sender {
    self.tempoRealDataSource = [[TempoRealDataSource alloc] initWithDelegate:self];
    
    loading = [[SSHUDView alloc] initWithTitle:@"Buscando localizações atuais"];
    [loading show];

    [self.tempoRealDataSource buscaLocalizacoesParaOnibus:onibus];
}

- (IBAction)mostraPontos:(id)sender {
    self.paradasDataSource = [[ParadaDataSource alloc] initWithDelegate:self];
    
    loading = [[SSHUDView alloc] initWithTitle:NSLocalized(@"buscando_paradas")];
    [loading show];

    [self.paradasDataSource buscaParadasParaOnibus:onibus];
}
@end
