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
@interface OnibusViewController ()

@property(unsafe_unretained, nonatomic) IBOutlet UILabel *letreiro;
@property(unsafe_unretained, nonatomic) IBOutlet UILabel *sentido;
@property(unsafe_unretained, nonatomic) IBOutlet UILabel *operacaoDiaUtil;
@property(unsafe_unretained, nonatomic) IBOutlet UILabel *operacaoSabado;
@property(unsafe_unretained, nonatomic) IBOutlet UILabel *operacaoDomingo;

@property(nonatomic, strong) Onibus* onibus;
@property(nonatomic, strong) SSHUDView *loading;
@property(nonatomic, strong) ParadaDataSource *paradasDataSource;
@property(nonatomic, strong) TempoRealDataSource *tempoRealDataSource;

@property(nonatomic, strong) UIPopoverController *masterPopoverController;
@end

@implementation OnibusViewController
- (void)viewWillAppear:(BOOL)animated{
    [self changeViewIfOnLandscape:self.interfaceOrientation];
}
- (void)viewDidLoad {
    [self configuraViewParaOnibus:self.onibus];
}
- (void) configuraViewParaOnibus: (Onibus *) onibus {
    self.onibus = onibus;
    
    if (self.masterPopoverController) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
    
    if([self isViewLoaded]){
        [self.letreiro setText:[onibus letreiro]];
        [self.sentido setText:[[onibus sentido] description]];
        [self.operacaoDiaUtil setText: [[onibus operacao] horarioDiaUtil ] ];
        [self.operacaoSabado setText: [[onibus operacao] horarioSabado ] ];
        [self.operacaoDomingo setText: [[onibus operacao] horarioDomingo ] ];
    }
}
- (void) recebeParadas: (NSArray *) paradas paraOnibus: (Onibus *) onibus {
    [self.loading completeQuicklyWithTitle:NSLocalized(@"pronto")];
    
    
    ParadasViewController *paradasController = [[ParadasViewController alloc]
                                                initWithParadas:paradas
                                                doOnibus:onibus
                                                paraLocalizacao:onibus.ponto.localizacao];
    
    [self.navigationController pushViewController:paradasController animated:YES];
}
- (void) problemaParaBuscarParadas {
    [self.loading failQuicklyWithTitle:NSLocalized(@"problema_buscando_paradas")];
}

- (void) recebeLocalizacoes: (NSArray *) localizacoes paraOnibus: (Onibus *) onibus {
    [self.loading completeQuicklyWithTitle:NSLocalized(@"pronto")];
    
    if ([localizacoes count] >0) {
        TempoRealViewController *controller = [[TempoRealViewController alloc]
                                               initWithLocalizacoes:localizacoes
                                               doOnibus: onibus];
        
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
    [self.loading failQuicklyWithTitle:@"Problema buscando localizações atuais"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)mostraLocalizacaoEmTempoReal:(id)sender {
    self.tempoRealDataSource = [[TempoRealDataSource alloc] initWithDelegate:self];
    
    self.loading = [[SSHUDView alloc] initWithTitle:@"Buscando localizações atuais"];
    [self.loading show];

    [self.tempoRealDataSource buscaLocalizacoesParaOnibus:self.onibus];
}

- (IBAction)mostraPontos:(id)sender {
    self.paradasDataSource = [[ParadaDataSource alloc] initWithDelegate:self];
    
    self.loading = [[SSHUDView alloc] initWithTitle:NSLocalized(@"buscando_paradas")];
    [self.loading show];

    [self.paradasDataSource buscaParadasParaOnibus:self.onibus];
}
- (void) setOnibus: (Onibus *) onibus {
    _onibus = onibus;
}
- (void)splitViewController:(UISplitViewController *)splitController
     willHideViewController:(UIViewController *)viewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)popoverController{
    barButtonItem.title = @"Master";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}
@end
