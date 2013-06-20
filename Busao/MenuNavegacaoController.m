//
//  MenuNavegacaoController.m
//  BusaoSP
//
//  Created by Erich Egert on 6/20/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "MenuNavegacaoController.h"
#import "FavoritosController.h"
#import "PontosPorProximidadeController.h"
#import "ListaPontoDeOnibusController.h"

@interface MenuNavegacaoController ()

@property (nonatomic, strong) NSArray* itens;
@property (nonatomic, strong) NSArray* controllers;


@end

@implementation MenuNavegacaoController

- (id)init {
    if (self = [super init]) {
        self.itens = @[@"Favoritos", @"Pontos Proximos", @"Procure pelo mapa", @"Procure por endereco"];
        self.controllers = @[[FavoritosController new],[ListaPontoDeOnibusController new], [PontosPorProximidadeController new]];
    }
    return self;
}

-(UIViewController*) defaultCenterPanelController {
    return [self.controllers objectAtIndex:1]; //TODO pegar das preferencias!
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.itens count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.itens objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controllerSelecionado = [self.controllers objectAtIndex:indexPath.row];

    self.contollerSelecionadoCallback(controllerSelecionado);

}

@end
