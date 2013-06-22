//
//  ListaOnibusController.m
//  Busao
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "ListaPontoDeOnibusController.h"
#import "NSStringWithMaxSize.h"
#import "GPSManager.h"
#import "Localizacao.h"
#import "Ponto.h"
@interface ListaPontoDeOnibusController (){
    BOOL reloading;
}
@property(nonatomic, strong) OnibusDataSource *onibusDataSource;
@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) UIViewController *semGps;
@property(nonatomic, strong) EGORefreshTableHeaderView *pullToRefresh;

- (void) atualizarListagem;
@end

@implementation ListaPontoDeOnibusController

- (id)init
{
    self = [super init];
    if (self) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.clearsSelectionOnViewWillAppear = NO;
            self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(verificaGps)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        UITabBarItem *listaItem = [[UITabBarItem alloc] initWithTitle:NSLocalized(@"localizacao")
                                                                image:[UIImage imageNamed:@"082-Location.png"]
                                                                  tag:1];
        self.tabBarItem = listaItem;
        self.navigationItem.title = NSLocalized(@"pontos_proximos");
        self.pontosSelecionados = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [self inicializaPullToRefresh];
    [self inicializaLocationManager];
    self.onibusDataSource = [[OnibusDataSource alloc] initWithDelegate:self];
    [self atualizarListagem];
}
- (void) inicializaLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
}
- (void) inicializaPullToRefresh{
    if (self.pullToRefresh == nil) {
        CGRect rect = CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height);
        self.pullToRefresh= [[EGORefreshTableHeaderView alloc] initWithFrame:rect];
		self.pullToRefresh.delegate = self;
		[self.tableView addSubview:self.pullToRefresh];
	}
	[self.pullToRefresh refreshLastUpdatedDate];
}
- (void) verificaGps{
    if([GPSManager isGPSDisabled]){
        if(!self.semGps){
            self.semGps = [[UIViewController alloc] initWithNibName:@"SemGps" bundle:[NSBundle mainBundle]];
            [self.view addSubview:self.semGps.view];
            [self.tableView setUserInteractionEnabled:NO];
        }
    }else{
        if(self.semGps){
            [self.semGps.view removeFromSuperview];
            self.semGps = nil;
        }
        [self.tableView setUserInteractionEnabled:YES];        
    }
}
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    
    [manager stopUpdatingLocation];
    
    double latitude = newLocation.coordinate.latitude;
    double longitude = newLocation.coordinate.longitude; 
    
    [[self appDelegate] setLocalizacaoAtual: [[Localizacao alloc] initWithLatitude:latitude eLongitude:longitude]];
    
    [self.onibusDataSource buscaPontosParaLocalizacao:[[self appDelegate]localizacaoAtual]];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if([self isSearching:tableView]){
        return nil;
    }
    Ponto *ponto = [self.pontos objectAtIndex:section];    
    double distanciaDoPontoAtual = [ponto.localizacao distanciaEntrePonto: [[self appDelegate]localizacaoAtual] ];
    NSString *distancia = [NSString stringWithFormat:@" %.0fm", distanciaDoPontoAtual];
    float tamanhoDistancia = [distancia sizeWithFont:[UIFont boldSystemFontOfSize:18]].width;
    
    NSString *descricao = [NSStringWithMaxSize removeExtraFromString:ponto.descricao withMaxWidth:self.tableView.frame.size.width - (tamanhoDistancia + 35)];
    
    return [NSString stringWithFormat:@"%@%@",  descricao, distancia];
}

- (void) atualizarListagem{
    reloading = YES;
    [self.locationManager startUpdatingLocation];
}
- (void) recebePontos: (NSArray *) _pontos paraLocalizacao:(Localizacao *)localizacao{
    [self.pontosSelecionados removeAllObjects];
    [self.onibusSelecionados removeAllObjects];
    self.pontos = _pontos;
    [self.tableView reloadData];
    [self listagemAtualizada];
}
- (void) problemaParaBuscarPontos{
    [self listagemAtualizada];
}
- (void) listagemAtualizada{
    reloading = NO;
	[self.pullToRefresh egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}
#pragma mark - PullToRefresh methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self atualizarListagem];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return reloading;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	[self.pullToRefresh egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[self.pullToRefresh egoRefreshScrollViewDidEndDragging:scrollView];
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.tableView reloadData];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
