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

@property(nonatomic, strong) NSMutableArray *onibus;

@end

@interface FavoritosController ()

@end

@implementation FavoritosController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Favoritos";
    self.onibus = [[NSMutableArray alloc] init];
    self.tableView.rowHeight = [OnibusTableCell rowHeight];
}

-(void) viewDidAppear:(BOOL)animated {
    if ([self.onibus count]>0) {
        [self.onibus removeAllObjects];
    }
    [self.onibus addObjectsFromArray:[LinhaDeOnibus todasWithContext:[self context]]];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.onibus count];
}

-(void) favorita:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint ponto = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:ponto];
    
    LinhaDeOnibus *selecionado = [self.onibus objectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.onibus removeObject:selecionado];
    [[self context] deleteObject:selecionado];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[OnibusTableCell identifier]];
    
    Onibus *onibus = [self.onibus objectAtIndex:indexPath.row];
    
    if(!cell){
        cell = [[OnibusTableCell alloc] initWithOnibus:onibus andDelegate:self];
    }
    
    return cell;
}

-(void) desfavorita: (UIGestureRecognizer *)gestureRecognizer {
    CGPoint ponto = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:ponto];
    
    LinhaDeOnibus *selecionado = [self.onibus objectAtIndex:[indexPath row]];
    
    [[self context] deleteObject:selecionado];
    [self.onibus removeObject:selecionado];
    
    [self saveManagedContext];
    
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
}

@end
