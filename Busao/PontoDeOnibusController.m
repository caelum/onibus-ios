//
//  ListaOnibusController.m
//  Busao
//
//  Created by Diego Chohfi on 3/29/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Twitter/TWTweetComposeViewController.h>
#import "EGORefreshTableHeaderView.h"
#import "SSHUDView.h"
#import "PontoDeOnibusController.h"
#import "ParadasViewController.h"
#import "Onibus.h"

@interface PontoDeOnibusController (){
    SSHUDView *loading;
}

- (void) tweet: (UIGestureRecognizer *) gesture;
@end

@implementation PontoDeOnibusController
@synthesize pontos, paradasDataSource, localizacaoAtual;

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
    self.paradasDataSource = [[ParadaDataSource alloc] initWithDelegate:self];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tweet:)];

    [self.tableView addGestureRecognizer:longPress];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [pontos count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    Onibus *onibus = [self buscaOnibus:indexPath];
    
    cell.textLabel.text = onibus.linha;
    cell.detailTextLabel.text = onibus.nome;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Onibus *onibus = [self buscaOnibus:indexPath];
    [onibus setPonto:[pontos objectAtIndex:indexPath.section]];
    loading = [[SSHUDView alloc] initWithTitle:NSLocalized(@"buscando_paradas")];
    [loading show];
    
    [paradasDataSource buscaParadasParaOnibus:onibus];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];    
}

- (void) recebeParadas: (NSArray *) paradas paraOnibus: (Onibus *) onibus {
    [loading completeQuicklyWithTitle:NSLocalized(@"pronto")];
    
    ParadasViewController *paradasController = [[ParadasViewController alloc] initWithParadas:paradas doOnibus:onibus paraLocalizaca:onibus.ponto.localizacao];    
    [self.navigationController pushViewController:paradasController animated:YES];
}
- (void) problemaParaBuscarParadas {
    [loading failQuicklyWithTitle:NSLocalized(@"problema_buscando_paradas")];
}
- (Onibus *)buscaOnibus:(NSIndexPath *)index{
    Ponto *ponto = [pontos objectAtIndex:index.section];
    Onibus *onibus = [ponto.onibuses objectAtIndex:index.row];
    return onibus;
}

- (void) tweet: (UIGestureRecognizer *) gesture{
    if([TWTweetComposeViewController canSendTweet]){
        CGPoint pontoTela = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:pontoTela];
        
        Onibus *onibus = [self buscaOnibus:index];
        
        TWTweetComposeViewController *tweet = [[TWTweetComposeViewController alloc] init];
        [tweet setInitialText:[NSString stringWithFormat:@"%@ %@", NSLocalized(@"pegando_onibus"), onibus.linha]];
        [self presentModalViewController:tweet animated:YES];
    }
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
@end
