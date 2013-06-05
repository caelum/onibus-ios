//
//  ListaOnibusController.m
//  Busao
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "EGORefreshTableHeaderView.h"
#import "PontoDeOnibusController.h"
#import "Onibus.h"
#import "ParadaDataSource.h"
#import "Ponto.h"
#import "DetalhesDoOnibusController.h"
#import "PontoUITableSection.h"


@interface PontoDeOnibusController ()

@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UISearchDisplayController *searchController;
@property(nonatomic, strong) NSMutableArray *onibusFiltrados;
@property(nonatomic, strong) NSMutableArray *onibusSelecionados;

@end

@implementation PontoDeOnibusController

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
    self.tableView.tableHeaderView = self.searchBar;
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar
                                                              contentsController:self];
    self.searchController.delegate = self;
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    
    [self hideSearchView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.onibusFiltrados = [[NSMutableArray alloc] init];
    self.onibusSelecionados = [[NSMutableArray alloc] init];
    
    self.tableView.allowsMultipleSelection = YES;
}

-(void) viewDidAppear:(BOOL)animated {
    UIBarButtonItem *mapa = [[UIBarButtonItem alloc] initWithTitle:@"Tempo real"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(irParaMapa)];
    
    UIBarButtonItem *favoritar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorite_star.png"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(favoritar)];
    
    self.navigationItem.rightBarButtonItem = mapa;
    self.navigationItem.leftBarButtonItem = favoritar;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self.onibusFiltrados removeAllObjects];
    for(Ponto *ponto in self.pontos){
        for(Onibus *onibus in ponto.onibuses){
            BOOL containsString = [onibus.letreiro rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound;
            if(containsString){
                [self.onibusFiltrados addObject:onibus];
            }
        }
    }
    return YES;
}

-(void) favoritar {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([self isSearching:tableView]){
        return 1;
    }
    return [self.pontos count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self isSearching:tableView]){
        return [self.onibusFiltrados count];
    }
    Ponto *ponto = [self.pontos objectAtIndex:section];
    return [ponto.onibuses count];
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    Ponto *ponto = [self.pontos objectAtIndex:section];
//    return ponto.descricao;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Onibus *onibus = [self buscaOnibus:indexPath paraTableView:tableView];
    
    if ([self.onibusSelecionados containsObject:onibus]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = [onibus letreiro];
    cell.detailTextLabel.text = [[onibus sentido] description];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Onibus *onibus = [self buscaOnibus:indexPath paraTableView:self.tableView];
    [onibus setPonto:[self.pontos objectAtIndex:indexPath.section]];
    
    if (!self.onibusSelecionados) {
        self.onibusSelecionados = [[NSMutableArray alloc] init];
    }
    
    UITableViewCell *selecionada = [tableView cellForRowAtIndexPath:indexPath];
    
    if (selecionada.accessoryType == UITableViewCellAccessoryCheckmark) {
        selecionada.accessoryType = UITableViewCellAccessoryNone;
        [self.onibusSelecionados removeObject:onibus];
        
    } else {
        if ([self.onibusSelecionados count] == 3) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Só é possível selecionar 3 ônibus ao mesmo tempo." delegate:self cancelButtonTitle:nil otherButtonTitles: @"Ok", nil];
            
            [alert show];
        } else {            
            selecionada.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.onibusSelecionados addObject:onibus];
        }
    }
}

-(void) irParaMapa {
    if ([self.onibusSelecionados count] > 0) {
        [self.navigationController pushViewController:[[DetalhesDoOnibusController alloc] initWithOnibuses:self.onibusSelecionados andLocalizacao:self.localizacaoAtual] animated:YES];
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Ponto *ponto = [self.pontos objectAtIndex:section];
    
    return [[PontoUITableSection alloc] initWithPonto:ponto andLocalizacaoAtual: self.localizacaoAtual];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [PontoUITableSection height];
}

- (Onibus *)buscaOnibus:(NSIndexPath *)index paraTableView: (UITableView *) tableView{
    if([self isSearching:tableView]){
        return [self.onibusFiltrados objectAtIndex:index.row];
    }
    Ponto *ponto = [self.pontos objectAtIndex:index.section];
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
