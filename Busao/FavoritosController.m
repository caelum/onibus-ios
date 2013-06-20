//
//  FavoritosController.m
//  BusaoSP
//
//  Created by Erich Egert on 6/7/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "FavoritosController.h"
#import "LinhaDeOnibus.h"

@interface FavoritosController()

@property(nonatomic, strong) NSMutableArray *favoritos;

@end

@interface FavoritosController ()

@end

@implementation FavoritosController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Favoritos";
    self.favoritos = [[NSMutableArray alloc] init];
    self.tableView.rowHeight = 55;
}

-(void) viewDidAppear:(BOOL)animated {
    if ([self.favoritos count]>0) {
        [self.favoritos removeAllObjects];
    }
    [self.favoritos addObjectsFromArray:[LinhaDeOnibus todasWithContext:[self context]]];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.favoritos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    LinhaDeOnibus *selecionada = [self.favoritos objectAtIndex:[indexPath row]];
    
    UIImageView *estrelaFavorito = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"favorite-star.png"]];
    
    UITapGestureRecognizer *onTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(desfavorita:)];
    [onTap setNumberOfTapsRequired:1];
    
    [estrelaFavorito addGestureRecognizer:onTap];
    [estrelaFavorito setUserInteractionEnabled:YES];
    
    cell.accessoryView = estrelaFavorito;
    
    cell.textLabel.text = [selecionada letreiro];
    cell.detailTextLabel.text = [selecionada origem];

    return cell;
}

-(void) desfavorita: (UIGestureRecognizer *)gestureRecognizer {
    CGPoint ponto = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:ponto];
    
    LinhaDeOnibus *selecionado = [self.favoritos objectAtIndex:[indexPath row]];
    
    [[self context] deleteObject:selecionado];
    [self.favoritos removeObject:selecionado];
    
    [self saveManagedContext];
    
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
}

@end
