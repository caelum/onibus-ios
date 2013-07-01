//
//  NovaTagController.m
//  BusaoSP
//
//  Created by Erich Egert on 7/1/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "NovaTagController.h"
#import "NovaTagDetalhesCell.h"
#import "LinhaDeOnibus+WithBehaviour.h"
#import "TagLinhas+WithBevaviour.h"

@interface NovaTagController ()

@property (nonatomic, weak) NSArray *selecionadosParaTag;
@property (nonatomic, strong) TagLinhas *novaTag;

@end

@implementation NovaTagController

- (id)initWithFavoritosSelecionados:(NSArray*) selecionados {
    if ([super initWithStyle:UITableViewStyleGrouped]) {
        self.selecionadosParaTag = selecionados;
        self.navigationItem.rightBarButtonItem =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                          target:self
                                                          action:@selector(criarNovaTag)];
        
        self.novaTag = [TagLinhas tagSelecaoLinhaParaLinhas:self.selecionadosParaTag
                                                 andContext:[self context]];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [NovaTagDetalhesCell registerCellXibInTableView:self.tableView];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"Detalhes da Tag";
    
    return @"Onibus vinculados ao atalho";
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) return [NovaTagDetalhesCell rowHeightForCell];
    
    else return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    
    return [self.selecionadosParaTag count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        NovaTagDetalhesCell *cell = [NovaTagDetalhesCell cellForTableView:self.tableView];
        
        return cell;
    } else if (indexPath.section==1) {
        
        static NSString *indentifier = @"Cell";
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:indentifier];
        
        if (!cell) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
        
        LinhaDeOnibus *onibus = [self.selecionadosParaTag objectAtIndex:indexPath.row];
        cell.textLabel.text = onibus.letreiro;
        cell.detailTextLabel.text = onibus.origem;
        
        return cell;
    }
    return nil;
}

-(void)criarNovaTag {
    if (self.novaTag) {
        [[self context]insertObject:self.novaTag];
        [self saveManagedContext];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        //TODO
    }

}

@end