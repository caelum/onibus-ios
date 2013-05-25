//
//  DetalhesDoOnibusController.m
//  BusaoSP
//
//  Created by Erich Egert on 5/24/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "DetalhesDoOnibusController.h"
#import "UILabel+DetailLabel.h"
#import "MKMapView+ZoomOut.h"
#import "Parada.h"
#import "AnnotationViewFactory.h"
#import "Veiculo.h"



@interface DetalhesDoOnibusController ()

@property(nonatomic, strong) MKMapView* mapView;

@property(nonatomic, strong) Onibus* onibus;
@property(nonatomic, strong) TempoRealDataSource *tempoRealDataSource;
@property(nonatomic, strong) ParadaDataSource *paradasDataSource;
@property(nonatomic, strong) Localizacao *localizacao;

@property(nonatomic, strong) UIImage *imagemVeiculo;
@property(nonatomic, strong) UIImage *imagemParada;

@end

@implementation DetalhesDoOnibusController

- (id)initWithOnibus: (Onibus*) onibus andLocalizacao: (Localizacao*) localizacao
{
    self = [super init];
    if (self) {
        self.mapView = [[MKMapView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.onibus = onibus;
        self.localizacao = localizacao;
        self.imagemVeiculo = [UIImage imageNamed:@"pin-bus-selected.png"];
        self.imagemParada = [UIImage imageNamed:@"pin-busstop-transp.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.view = self.mapView;
    [self.view addSubview:[UILabel detailLabelWithText: self.onibus.letreiro ]];
    [self buscaDetalhesDoOnibus];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKAnnotationView *annotationView = [AnnotationViewFactory createViewForAnnotation:annotation inMapView:self.mapView];
    
    if([annotation isKindOfClass:[Parada class]]){
        annotationView.image = self.imagemParada;
    }
    
    if([annotation isKindOfClass:[Veiculo class]]){
        annotationView.image = self.imagemVeiculo;
    }

    
    return annotationView;
}

- (void)buscaDetalhesDoOnibus {
    self.tempoRealDataSource = [[TempoRealDataSource alloc] initWithDelegate:self];
    [self.tempoRealDataSource buscaLocalizacoesParaOnibus:self.onibus];
    
    self.paradasDataSource = [[ParadaDataSource alloc] initWithDelegate:self];
    [self.paradasDataSource buscaParadasParaOnibus:self.onibus];
    
    //    self.loading = [[SSHUDView alloc] initWithTitle:NSLocalized(@"buscando_paradas")];
    //    [self.loading show];
    
}

- (BOOL)mesmaParadaParaLocalizacao: (Parada *) parada {
    return [self.localizacao isEqual:parada.localizacao];
}

- (void) recebeParadas: (NSArray *) paradas paraOnibus: (Onibus *) onibus {
//    [self.loading completeQuicklyWithTitle:NSLocalized(@"pronto")];
    [self.mapView addAnnotations:paradas];
    
}
- (void) problemaParaBuscarParadas {
//    [self.loading failQuicklyWithTitle:NSLocalized(@"problema_buscando_paradas")];
}

-(void) problemaParaBuscarLocalizacoes {
    
}

- (void) recebeLocalizacoes: (NSArray *) localizacoes paraOnibus: (Onibus *) onibus {
//    [self.loading completeQuicklyWithTitle:NSLocalized(@"pronto")];
    
    if ([localizacoes count] >0) {
        for (id<MKAnnotation> local in localizacoes) {
            [self.mapView addAnnotation:local];
        }
        [self.mapView zoomOut];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tempo real"
                                                        message:@"Nenhuma veiculo localizado no momento"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    
}

@end
