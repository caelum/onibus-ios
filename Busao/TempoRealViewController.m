//
//  TempoRealViewController.m
//  BusaoSP
//
//  Created by Erich Egert on 10/23/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "TempoRealViewController.h"
#import "AnnotationViewFactory.h"
#import "UILabel+DetailLabel.h"
@interface TempoRealViewController ()

@property(nonatomic, strong) NSArray* localizacoes;
@property(nonatomic, strong) Onibus* onibus;

@end



@implementation TempoRealViewController

@synthesize mapView;

-(id)initWithLocalizacoes: (NSArray *) localizacoesTempoReal doOnibus: (Onibus *) onibusSelecionado {
    
    self = [super init];
    if (self) {
        self.mapView = [[MKMapView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.onibus = onibusSelecionado;
        self.localizacoes = localizacoesTempoReal;
        self.title = @"Tempo real";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.view = mapView;
    [self.view addSubview:[UILabel detailLabelWithText: self.onibus.letreiro withCentralization:NO]];
    
    for (id<MKAnnotation> local in self.localizacoes) {
        [mapView addAnnotation:local];
    }
    [self.mapView zoomOut];
    
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
}

- (MKAnnotationView *)mapView:(MKMapView *) mapView_ viewForAnnotation:(id <MKAnnotation>)annotation {
    MKAnnotationView *annotationView = [AnnotationViewFactory createViewForAnnotation:annotation inMapView: mapView_];
    
    if([annotation isKindOfClass:[Veiculo class]]){
        annotationView.image = [UIImage imageNamed:@"pin-bus-selected.png"];
        annotationView.selected = YES;
    }
    
    return annotationView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
