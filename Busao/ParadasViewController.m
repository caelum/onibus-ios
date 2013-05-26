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
@end

@implementation ParadasViewController

-(id)initWithParadas: (NSArray *) paradas doOnibus: (Onibus *) onibus paraLocalizacao: (Localizacao *) localizacao {
    self = [super init];
    if (self) {
        self.mapView = [[MKMapView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.paradas = paradas;
        self.localizacao = localizacao;
        self.onibus = onibus;
        self.title = NSLocalized(@"itinerario");
    }
    return self;
}

- (void)viewDidLoad{
    self.mapView.delegate = self;
    [self adicionaPontos];
    [self.view addSubview:self.mapView];
    [self.view addSubview:[UILabel detailLabelWithText:self.onibus.letreiro withCentralization:NO]];
}
- (void) adicionaPontos {
    [self.mapView addAnnotations:self.paradas];
    [self.mapView zoomOut];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKAnnotationView *annotationView = [AnnotationViewFactory createViewForAnnotation:annotation inMapView:self.mapView];
    
    if([annotation isKindOfClass:[Parada class]]){
        if([self mesmaParadaParaLocalizacao: annotation]){
            annotationView.image = [UIImage imageNamed:@"pin-bus-selected.png"];
            annotationView.selected = YES;
        }
    }
    
    return annotationView;
}
- (BOOL)mesmaParadaParaLocalizacao: (Parada *) parada {
    return [self.localizacao isEqual:parada.localizacao];
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
@end
