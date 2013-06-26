//
//  FavoritosController.m
//  BusaoSP
//
//  Created by Erich Egert on 6/7/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "FavoritosController.h"
#import "LinhaDeOnibus.h"
#import "DetalhesDoOnibusController.h"



@interface FavoritosController()

@property(nonatomic, strong) NSMutableArray *onibuses;
@property(nonatomic, strong) NSMutableArray *onibusSelecionados;

@end

@interface FavoritosController ()

@end

@implementation FavoritosController

-(id) init {
    if(self = [super initWithStyle:UITableViewStylePlain]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tempo real"
                                                                                  style:UIBarButtonItemStyleBordered
                                                                                 target:self
                                                                                 action:@selector(irParaMapa)];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Favoritos";
    self.onibuses = [[NSMutableArray alloc] init];
    self.tableView.rowHeight = [OnibusTableCell rowHeight];
    self.onibusSelecionados = [NSMutableArray new];
    self.tableView.allowsMultipleSelection = YES;
}

-(void) viewDidAppear:(BOOL)animated {
    if ([self.onibuses count]>0) {
        [self.onibuses removeAllObjects];
    }
    [self.onibuses addObjectsFromArray:[LinhaDeOnibus todasWithContext:[self context]]];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.onibuses count];
}

-(void) favorita:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint ponto = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:ponto];
    
    id<OnibusInfo> selecionado = [self.onibuses objectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.onibuses removeObject:selecionado];
    [[self context] deleteObject:selecionado];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OnibusTableCell *cell = (OnibusTableCell*)[tableView dequeueReusableCellWithIdentifier:[OnibusTableCell identifier]];
    
    id<OnibusInfo> onibus = [self.onibuses objectAtIndex:indexPath.row];
    
    NSLog(@"ONIBUS: %@  ------>   ONIBUSES %@",onibus,  self.onibuses);
    
    if(!cell){
        cell = [[OnibusTableCell alloc] initWithOnibus:onibus andDelegate:self];
    } else {
        [cell configuraCelulaParaOnibus:onibus];
    }
    
    
    return cell;
}

-(void) desfavorita: (UIGestureRecognizer *)gestureRecognizer {
    CGPoint ponto = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:ponto];
    
    id<OnibusInfo> selecionado = [self.onibuses objectAtIndex:[indexPath row]];
    
    [[self context] deleteObject:selecionado];
    [self.onibuses removeObject:selecionado];
    
    [self saveManagedContext];
    
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id<OnibusInfo> onibus = [self.onibuses objectAtIndex:indexPath.row];
    
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

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [(OnibusTableCell*)cell aplicaCorDaCelulaParaOnibusSelecionados:self.onibusSelecionados];
}

#pragma mark - Custom Methods

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

@end
