//
//  OnibusTableself.m
//  BusaoSP
//
//  Created by Erich Egert on 6/16/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "OnibusTableCell.h"


@interface OnibusTableCell()

@property(nonatomic, weak) id<OnibusInfo> onibus;
@property(nonatomic, weak) id<OnibusTableCellDelagate> delegateFavorito;

@end

@implementation OnibusTableCell



- (id)initWithOnibus: (id<OnibusInfo>) onibus andDelegate: (id<OnibusTableCellDelagate>) delegate {
    
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[OnibusTableCell identifier]];
    if (self) {
        self.delegateFavorito = delegate;
        self.onibus = onibus;
        [self montaCelula: self.onibus.favorito];
        
    }
    return self;
}

-(void) aplicaCorDaCelulaParaOnibusSelecionados: (NSArray*) onibusSelecionados {
    if ([onibusSelecionados containsObject:self.onibus]) {
        self.backgroundColor = [OnibusTableCell corLinhaSelecionada];
        self.detailTextLabel.textColor = [UIColor whiteColor];
        self.textLabel.textColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [OnibusTableCell corLinhaPadrao];
        self.detailTextLabel.textColor = [UIColor grayColor];
        self.textLabel.textColor = [UIColor blackColor];
    }
    if ([onibusSelecionados containsObject:self.onibus]) {
        self.textLabel.text = [NSString stringWithFormat:@"\u2611 %@", self.onibus.letreiro];
    } else {
        self.textLabel.text = [NSString stringWithFormat:@"\u2B1C %@", self.onibus.letreiro];
    }
}

-(void) mudaStatusFavorito:(UIGestureRecognizer *)gestureRecognizer {
    [self montaCelula: !self.onibus.favorito]; //inverte o status atual da estrela
    
    [self.delegateFavorito favorita:gestureRecognizer];
}

+(UIColor*) corLinhaSelecionada {
    static UIColor *corLinhaSelecionada = nil;
    
    if (!corLinhaSelecionada) {
        corLinhaSelecionada = [UIColor colorWithRed:50.0/255 green:120.0/255 blue:250.0/255 alpha:1];
    }
    
    return corLinhaSelecionada;
}

+(UIColor*) corLinhaPadrao {
    static UIColor *corLinhaPadrao = nil;
    
    if (!corLinhaPadrao) {
        corLinhaPadrao = [UIColor whiteColor];
    }
    
    return corLinhaPadrao;
}

+(NSInteger) rowHeight {
    return 55;
}

-(void) montaCelula: (BOOL) onibusFavorito {
    
    NSString *imagem = nil;
    
    if (onibusFavorito) {
        imagem = @"favorite-star.png";
    } else {
        imagem = @"favorite-star-gray.png";
    }    
    
    if (self.selected) {
        self.textLabel.text = [NSString stringWithFormat:@"\u2611 %@", self.onibus.letreiro];
    } else {
        self.textLabel.text = [NSString stringWithFormat:@"\u2B1C %@", self.onibus.letreiro];
    }
    
    UIImageView *estrelaFavorito = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    estrelaFavorito.image = [UIImage imageNamed:imagem];
    
    UITapGestureRecognizer *onTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mudaStatusFavorito:)];
    [onTap setNumberOfTapsRequired:1];
    
    [estrelaFavorito addGestureRecognizer:onTap];
    [estrelaFavorito setUserInteractionEnabled:YES];
    
    self.accessoryView = estrelaFavorito;
    
    self.textLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    self.detailTextLabel.text = [self.onibus descricaoSentido];
    self.detailTextLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
}

+(NSString*) identifier {
    return @"OnibusTableCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
