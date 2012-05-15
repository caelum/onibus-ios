//
//  ParadasViewController.m
//  Busao
//
//  Created by Diego Chohfi on 3/30/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "ParadasViewController.h"
#import "AnnotationViewFactory.h"
#import "MKMapView+ZoomOut.h"
#import "UILabel+DetailLabel.h"
#import "Parada.h"
#import "Ponto.h"
@interface ParadasViewController ()

@property (nonatomic, strong) NSArray *paradas;
@property (nonatomic, strong) Localizacao *localizacao;
@property (nonatomic, strong) Onibus *onibus;
- (void) adicionaPontos;
- (BOOL)mesmaParadaParaLocalizacao: (Parada *) parada;
@end

@implementation ParadasViewController
@synthesize mapView, paradas, localizacao, onibus;

-(id)initWithParadas: (NSArray *) _paradas doOnibus: (Onibus *) _onibus paraLocalizaca: (Localizacao *) _localizacao {
    self = [super init];
    if (self) {
        self.mapView = [[MKMapView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.paradas = _paradas;
        self.localizacao = _localizacao;
        self.onibus = _onibus;
        self.title = NSLocalized(@"itinerario");
    }
    return self;
}

- (void)viewDidLoad
{
    self.mapView.delegate = self;
    [self adicionaPontos];
    self.view = mapView;
    [self.view addSubview:[UILabel detailLabelWithText:onibus.nome]];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
}
- (void) adicionaPontos {    
    for (id<MKAnnotation> local in paradas) {
        [mapView addAnnotation:local];
    }
    [self.mapView zoomOut];
}

- (MKAnnotationView *)mapView:(MKMapView *)_mapView viewForAnnotation:(id <MKAnnotation>)annotation {   
    MKAnnotationView *annotationView = [AnnotationViewFactory createViewForAnnotation:annotation inMapView:_mapView];
    
    if([annotation isKindOfClass:[Parada class]]){
        if([self mesmaParadaParaLocalizacao: annotation]){
            annotationView.image = [UIImage imageNamed:@"pin-bus-selected.png"];
            annotationView.selected = YES;
        }
    }
    
    return annotationView;
}
- (BOOL)mesmaParadaParaLocalizacao: (Parada *) parada {
    if (parada.localizacao.latitude == localizacao.latitude && parada.localizacao.longitude == localizacao.longitude) {
        return YES;
    }
    return NO;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
@end
