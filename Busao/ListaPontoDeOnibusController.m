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
@interface ListaPontoDeOnibusController (){
    EGORefreshTableHeaderView *pullToRefresh;
    BOOL reloading;
}
@property(nonatomic, strong) OnibusDataSource *onibusDataSource;
@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) UIViewController *semGps;

- (void) atualizarListagem;
@end

@implementation ListaPontoDeOnibusController
@synthesize onibusDataSource, locationManager, semGps;

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {      
        UITabBarItem *listaItem = [[UITabBarItem alloc] initWithTitle:NSLocalized(@"localizacao") image:[UIImage imageNamed:@"082-Location.png"] tag:1];
        self.tabBarItem = listaItem;
        self.navigationItem.title = NSLocalized(@"pontos_proximos");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (pullToRefresh == nil) {
        CGRect rect = CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height); 
        pullToRefresh= [[EGORefreshTableHeaderView alloc] initWithFrame:rect];
		pullToRefresh.delegate = self;
		[self.tableView addSubview:pullToRefresh];		
	}

	[pullToRefresh refreshLastUpdatedDate];
    
    self.onibusDataSource = [[OnibusDataSource alloc] initWithDelegate:self];     
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    [self atualizarListagem];
}
- (void) applicationDidBecameActive{
    if([GPSManager isGPSDisabled]){
        if(!semGps){
            semGps = [[UIViewController alloc] initWithNibName:@"SemGps" bundle:[NSBundle mainBundle]];
            [self.view addSubview:semGps.view];
            [self.tableView setUserInteractionEnabled:NO];
        }
    }else{
        if(semGps){
            [semGps.view removeFromSuperview];
            semGps = NULL;
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
        
    self.localizacaoAtual = [[Localizacao alloc] initWithLatitude:latitude eLongitude:longitude];
    
    [self.onibusDataSource buscaPontosParaLocalizacao:self.localizacaoAtual];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if([self isSearching:tableView]){
        return nil;
    }
    Ponto *ponto = [self.pontos objectAtIndex:section];    
    double distanciaDoPontoAtual = [ponto.localizacao distanciaEntrePonto:self.localizacaoAtual];
    NSString *distancia = [NSString stringWithFormat:@" %.0fm", distanciaDoPontoAtual];
    float tamanhoDistancia = [distancia sizeWithFont:[UIFont boldSystemFontOfSize:18]].width;
    
    NSString *descricao = [NSStringWithMaxSize removeExtraFromString:ponto.descricao withMaxWidth:self.tableView.frame.size.width - (tamanhoDistancia + 35)];
    
    return [NSString stringWithFormat:@"%@%@",  descricao, distancia];
}

- (void) atualizarListagem{
    reloading = YES;
    [locationManager startUpdatingLocation];
}
- (void) recebePontos: (NSArray *) _pontos paraLocalizacao:(Localizacao *)localizacao{
    self.pontos = _pontos;
    [self.tableView reloadData];
    [self listagemAtualizada];
}
- (void) problemaParaBuscarPontos{
    [self listagemAtualizada];
}
- (void) listagemAtualizada{
    reloading = NO;
	[pullToRefresh egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
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
	[pullToRefresh egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[pullToRefresh egoRefreshScrollViewDidEndDragging:scrollView];
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.tableView reloadData];
}
- (void)viewDidUnload{
    pullToRefresh = nil;
    semGps = nil;
}
@end
