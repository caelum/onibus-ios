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
@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSDictionary* itens;
@property (nonatomic, strong) NSDictionary* controllers;


@end

@implementation MenuNavegacaoController

- (id)init {
    if (self = [super init]) {
        self.sections = @[@"Busque por onibus",  @"Favoritos", @"Configurações"];
        
        self.itens = @{[self.sections objectAtIndex:0] : @[@"Pontos Proximos", @"Por endereço", @"Por linha"],
                       [self.sections objectAtIndex:1] : @[@"Todos", @"Faculdade - Casa", @"Trabalho - Casa"],
                       [self.sections objectAtIndex:2] : @"Editar preferências"};
        
        self.controllers = @{[self.sections objectAtIndex:0] :
                                    @[[ListaPontoDeOnibusController new], [PontosPorProximidadeController new], [NSObject new]],
                             [self.sections objectAtIndex:1] :
                                    @[[FavoritosController new], [NSObject new], [NSObject new]],
                             [self.sections objectAtIndex:2] : [NSObject new]};

    }
    return self;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    viewSection.backgroundColor = [UIColor grayColor];
    
    UIFont *font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(10)];
    NSString *titulo = [self.sections objectAtIndex:section];
    CGSize tamanhoLabel = [titulo sizeWithFont:font];
    UILabel *tituloSection = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, tamanhoLabel.width, tamanhoLabel.height)];
    tituloSection.text = titulo;
    [tituloSection sizeToFit];
    tituloSection.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    
    
    [viewSection addSubview:tituloSection];
    
    return viewSection;
}

-(UIViewController*) defaultCenterPanelController {
    return [[self.controllers objectForKey:[self.sections objectAtIndex:0]] objectAtIndex:0]; //TODO pegar das preferencias!
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.itens count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSObject *itensDaSection = [self.itens objectForKey:[self.sections objectAtIndex:section]];
    
    if ([itensDaSection isKindOfClass:[NSArray class]]) {
        return [((NSArray*) itensDaSection) count];
    } else {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *titulo = nil;
    
    NSObject *itensDaSection = [self.itens objectForKey:[self.sections objectAtIndex:indexPath.section]];
    if ([itensDaSection isKindOfClass:[NSArray class]]) {
        titulo = [((NSArray*) itensDaSection) objectAtIndex:indexPath.row];
    } else {
        titulo = (NSString*) itensDaSection;
    }
    
    cell.textLabel.text = titulo;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controllerSelecionado = nil;

    NSObject *itensDaSection = [self.controllers objectForKey:[self.sections objectAtIndex:indexPath.section]];
    if ([itensDaSection isKindOfClass:[NSArray class]]) {
        controllerSelecionado = [((NSArray*) itensDaSection) objectAtIndex:indexPath.row];
    } else {
        controllerSelecionado = (UIViewController*) itensDaSection;
    }
    
    self.contollerSelecionadoCallback(controllerSelecionado);

}

@end
