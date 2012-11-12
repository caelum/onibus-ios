//
//  OnibusDisponiveis.m
//  Busao
//
//  Created by Diego Chohfi on 4/3/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "PontosPorProximidadeController.h"
#import "AnnotationViewFactory.h"
#import "MKMapView+ZoomOut.h"
#import "PontoDeOnibusController.h"
#import "UILabel+DetailLabel.h"
#import "Ponto.h"
#import "Localizacao.h"
#import "GPSManager.h"

@interface PontosPorProximidadeController ()

@property(nonatomic, strong) OnibusDataSource *dataSource;
@property(nonatomic, assign) BOOL jaBuscouUsuario;
- (void) removerUltimaLocalizacao;
- (void) removerPontos;
- (void) criaSpinner;
- (void) criaDropPin;
@end

@implementation PontosPorProximidadeController
@synthesize jaBuscouUsuario, mapView, dataSource;

-(id)init {
    self = [super init];
    if (self) {
        jaBuscouUsuario = false;
        self.mapView = [[MKMapView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.mapView.showsUserLocation = YES;
        self.mapView.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(verificaGps)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        UITabBarItem *listaItem = [[UITabBarItem alloc] initWithTitle:NSLocalized(@"mapa") image:[UIImage imageNamed:@"088-Map.png"] tag:1];
        
        self.tabBarItem = listaItem;
        self.navigationItem.title = NSLocalized(@"busque_no_mapa");
        
        dataSource = [[OnibusDataSource alloc] initWithDelegate:self];
    }
    return self;
}

-(void)viewDidLoad {    
    [self criaDropPin];
    [self.mapView zoomOut];
    
    self.view = mapView;
    [self.view addSubview:[UILabel detailLabelWithText:NSLocalized(@"pontos_proximos_pino")]];
}
- (void) verificaGps {
    if([GPSManager isGPSDisabled]){
        self.navigationItem.leftBarButtonItem = NULL;
    }else{
        MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
        self.navigationItem.leftBarButtonItem = buttonItem;        
    }
}
- (void) criaDropPin{
    UIBarButtonItem *dropPin = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"242-Aim.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(atualizarLocalizacao)];
    self.navigationItem.rightBarButtonItem = dropPin;
}
- (void) criaSpinner {
    UIActivityIndicatorView *activityIndicator = 
    [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    
    self.navigationItem.rightBarButtonItem = barButton;
    [activityIndicator startAnimating];
}
- (void)mapView:(MKMapView *)_mapView didUpdateUserLocation:(MKUserLocation *)userLocation      {
    CLLocationAccuracy accuracy = userLocation.location.horizontalAccuracy;
    if(accuracy >= 30 && !jaBuscouUsuario){
        jaBuscouUsuario = YES;
        self.mapView.showsUserLocation = false;
        Localizacao *localizacao = [[Localizacao alloc] initWithLatitude:mapView.userLocation.coordinate.latitude eLongitude:mapView.userLocation.coordinate.longitude];
        [dataSource buscaPontosParaLocalizacao:localizacao];
    }
}

- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView {
    jaBuscouUsuario = false;
}

- (MKAnnotationView *)mapView:(MKMapView *)_mapView viewForAnnotation:(id <MKAnnotation>)annotation {   
    return [AnnotationViewFactory createViewForAnnotation: annotation inMapView:_mapView];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code]== kCLAuthorizationStatusDenied || [error code] == kCLAuthorizationStatusRestricted) 
     {
        UIBarButtonItem *erroButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"253-Info.png"] style:UIBarButtonSystemItemDone target:self action:@selector(semAcessoAoGPS)];
        self.navigationItem.leftBarButtonItem = erroButton;
     }
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    if(![view.annotation isKindOfClass:[Ponto class]])
        return;
    Ponto *ponto = (Ponto *) view.annotation;
    
    PontoDeOnibusController *onibusController = [[PontoDeOnibusController alloc] initWithPonto:ponto];
    [self.navigationController pushViewController:onibusController animated:YES]; 
}
- (void)atualizarLocalizacao{
    [self criaSpinner];
    
    self.mapView.showsUserLocation = false;
    Localizacao *localizacao = [[Localizacao alloc] initWithLatitude:mapView.centerCoordinate.latitude eLongitude:mapView.centerCoordinate.longitude];
    [dataSource buscaPontosParaLocalizacao:localizacao];
}
- (void) recebePontos: (NSArray *) pontos paraLocalizacao:(Localizacao *)localizacao{
    [self removerPontos];
    [self removerUltimaLocalizacao];
    [self.mapView addAnnotation:localizacao];
    [pontos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.mapView addAnnotation:obj];
    }];
    [self.mapView zoomOut];
    [self criaDropPin];
}
- (void) problemaParaBuscarPontos{

}
- (void) removerPontos{
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        if([annotation isKindOfClass:[Ponto class]]){
            [self.mapView removeAnnotation:annotation];
        }
    }
}
- (void)removerUltimaLocalizacao {
    for(id<MKAnnotation> anotacao in mapView.annotations){
        if([anotacao isKindOfClass:[Localizacao class]]){
            [mapView removeAnnotation:anotacao];
        }
    }
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
