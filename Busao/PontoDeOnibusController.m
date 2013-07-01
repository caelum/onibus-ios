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
#import "LinhaDeOnibus+WithBehaviour.h"



@interface PontoDeOnibusController ()

@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UISearchDisplayController *searchController;
@property(nonatomic, strong) NSMutableArray *onibusFiltrados;


@end

@implementation PontoDeOnibusController

- (id)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tempo real"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(irParaMapa)];
        self.navigationItem.title = NSLocalized(@"onibus");
    }
    return self;
}

- (id)initWithPonto: (Ponto *) ponto
{
    self = [self init];
    if (self) {
        self.pontos = [NSArray arrayWithObject:ponto];
        self.pontosSelecionados = [[NSMutableArray alloc] init];
        [self.pontosSelecionados addObject:ponto];
        
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
    self.searchBar.delegate = self;
    
    [self hideSearchView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.onibusFiltrados = [[NSMutableArray alloc] init];
    self.onibusSelecionados = [[NSMutableArray alloc] init];
    
    self.tableView.allowsMultipleSelection = YES;
}

-(void) viewWillAppear:(BOOL)animated {
    //TODO isso tah aqui pela heranca mal usada, REFACTOR!!
    self.tableView.rowHeight = [OnibusTableCell rowHeight];
    
    [self atualizaBotaoTempoReal];

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
    
    if ([self.pontosSelecionados containsObject:ponto]) {
        return [ponto.onibuses count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[OnibusTableCell identifier]];
    
    Onibus *onibus = [self buscaOnibus:indexPath paraTableView:tableView];
    
    if(!cell){
        cell = [[OnibusTableCell alloc] initWithOnibus:onibus andDelegate:self];
    }
    
    
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    [(OnibusTableCell*)cell aplicaCorDaCelulaParaOnibusSelecionados:self.onibusSelecionados];
}

- (void)favorita:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint ponto = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:ponto];
    
    Onibus *selecionado = [self buscaOnibus:indexPath paraTableView:self.tableView];
    [LinhaDeOnibus mudaStatusDeFavoritoParaOnibus:selecionado noContext:[self context]];
    
    [self saveManagedContext];
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Onibus *onibus = [self buscaOnibus:indexPath paraTableView:self.tableView];
    [onibus setPonto:[self.pontos objectAtIndex:indexPath.section]];
    
    if (!self.onibusSelecionados) {
        self.onibusSelecionados = [[NSMutableArray alloc] init];
    }
    
    if ([self.onibusSelecionados containsObject:onibus]) {
        [self.onibusSelecionados removeObject:onibus];
        
    } else {
        if ([self.onibusSelecionados count] == 3) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Só é possível selecionar 3 ônibus ao mesmo tempo." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: @"Limpar Seleção", nil];
            
            [alert show];
        } else {            
            [self.onibusSelecionados addObject:onibus];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self atualizaBotaoTempoReal];
    OnibusTableCell *cell = (OnibusTableCell*) [self.tableView cellForRowAtIndexPath:indexPath];
    [cell aplicaCorDaCelulaParaOnibusSelecionados:self.onibusSelecionados];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1) {
        [self.onibusSelecionados removeAllObjects];
        [self.tableView reloadData];
        [self atualizaBotaoTempoReal];
    }
}


-(void) atualizaBotaoTempoReal {
    if ([self.onibusSelecionados count] > 0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        [self.navigationItem.rightBarButtonItem setTintColor: [OnibusTableCell corLinhaSelecionada]];
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        [self.navigationItem.rightBarButtonItem setTintColor:nil];
    }
}

-(void) irParaMapa {
    if ([self.onibusSelecionados count] > 0) {
        [self.navigationController pushViewController:[[DetalhesDoOnibusController alloc] initWithOnibuses:self.onibusSelecionados andLocalizacao:[[self appDelegate]localizacaoAtual]] animated:YES];
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Ponto *ponto = [self.pontos objectAtIndex:section];
    
    UIView *viewSection = [[PontoUITableSection alloc] initWithPonto:ponto
                                                 andLocalizacaoAtual: [[self appDelegate]localizacaoAtual]
                                                         andCallback:^{
                                                             if ([self.pontosSelecionados containsObject:ponto]) {
                                                                 [self.pontosSelecionados removeObject:ponto];
                                                             } else {
                                                                 [self.pontosSelecionados addObject:ponto];
                                                             }
                                                             [self.tableView reloadData];
                                                         }];
    
    UITapGestureRecognizer *onTap = [[UITapGestureRecognizer alloc] initWithTarget:viewSection action:@selector(executaSelecao)];
    [onTap setNumberOfTapsRequired:1];
    
    [viewSection addGestureRecognizer:onTap];
    [viewSection setUserInteractionEnabled:YES];
    
    return viewSection;
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
