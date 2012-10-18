//
//  ListaOnibusController.m
//  Busao
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "EGORefreshTableHeaderView.h"
#import "SSHUDView.h"
#import "PontoDeOnibusController.h"
#import "ParadasViewController.h"
#import "Onibus.h"

@interface PontoDeOnibusController (){
    SSHUDView *loading;
}
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UISearchDisplayController *searchDisplayController;
@property(nonatomic, strong) NSMutableArray *onibusFiltrados;
@end

@implementation PontoDeOnibusController
@synthesize pontos, paradasDataSource, localizacaoAtual, searchBar, searchDisplayController, onibusFiltrados;

- (id)initWithPonto: (Ponto *) ponto
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {     
        self.pontos = [NSArray arrayWithObject:ponto];
        self.navigationItem.title = NSLocalized(@"onibus");
    }
    return self;
}

- (void)viewDidLoad
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.tableView.tableHeaderView = searchBar;
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
    [self hideSearchView];
    
    self.paradasDataSource = [[ParadaDataSource alloc] initWithDelegate:self];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.onibusFiltrados = [[NSMutableArray alloc] init];
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [onibusFiltrados removeAllObjects];
    for(Ponto *ponto in pontos){
        for(Onibus *onibus in ponto.onibuses){
            BOOL containsString = [onibus.letreiro rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound;
            if(containsString){
                [onibusFiltrados addObject:onibus];
            }
        }
    }
    return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([self isSearching:tableView]){
        return 1;
    }
    return [pontos count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self isSearching:tableView]){
        return [onibusFiltrados count];
    }
    Ponto *ponto = [pontos objectAtIndex:section];
    return [ponto.onibuses count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    Ponto *ponto = [pontos objectAtIndex:section];
    return ponto.descricao;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Onibus *onibus = [self buscaOnibus:indexPath paraTableView:tableView];
    
    cell.textLabel.text = [onibus letreiro];
    cell.detailTextLabel.text = [[onibus sentido] description];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Onibus *onibus = [self buscaOnibus:indexPath paraTableView:tableView];
    [onibus setPonto:[pontos objectAtIndex:indexPath.section]];
    loading = [[SSHUDView alloc] initWithTitle:NSLocalized(@"buscando_paradas")];
    [loading show];
    
    [paradasDataSource buscaParadasParaOnibus:onibus];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];    
}

- (void) recebeParadas: (NSArray *) paradas paraOnibus: (Onibus *) onibus {
    [loading completeQuicklyWithTitle:NSLocalized(@"pronto")];
    
    ParadasViewController *paradasController = [[ParadasViewController alloc] initWithParadas:paradas
                                                                                     doOnibus:onibus
                                                                               paraLocalizaca:onibus.ponto.localizacao];
    
    [self.navigationController pushViewController:paradasController animated:YES];
}
- (void) problemaParaBuscarParadas {
    [loading failQuicklyWithTitle:NSLocalized(@"problema_buscando_paradas")];
}
- (Onibus *)buscaOnibus:(NSIndexPath *)index paraTableView: (UITableView *) tableView{
    if([self isSearching:tableView]){
        return [onibusFiltrados objectAtIndex:index.row];
    }
    Ponto *ponto = [pontos objectAtIndex:index.section];
    Onibus *onibus = [ponto.onibuses objectAtIndex:index.row];
    return onibus;            
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
- (BOOL) isSearching:(UITableView *)tableView {
    return !(tableView == self.tableView);
}
- (void) hideSearchView {
    CGRect tableViewBounds = self.tableView.bounds;
    tableViewBounds.origin.y = tableViewBounds.origin.y + self.searchBar.bounds.size.height;
    self.tableView.bounds = tableViewBounds;
}
@end
