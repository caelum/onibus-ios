//
//  LegendaOnibus.m
//  BusaoSP
//
//  Created by Erich Egert on 6/4/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "LegendaOnibus.h"

@implementation LegendaOnibus

+(CGPoint) addOnibus: (Onibus*) onibus andImage: (UIImage*) imagem andStartingAt: (CGPoint) origem inView: (UIView*) view{
    int tamanhoImagem = imagem.size.width;
    CGPoint novaOrigem = CGPointMake(origem.x+5, origem.y);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(novaOrigem.x, 0, imagem.size.width, imagem.size.height)];
    [imageView setImage:imagem];
    
    UILabel *letreiro = [self labelWithText:onibus.letreiro
                                         andStartingAtX:novaOrigem.x + tamanhoImagem
                                                   andY:novaOrigem.y];
    
    UILabel *linha = [self labelWithText:[onibus.sentido description]
                                      andStartingAtX:novaOrigem.x + tamanhoImagem
                                                andY:novaOrigem.y+15 withFontSize:10];
    
    int larguraLinha = linha.frame.size.width;
    int larguraLetreiro = letreiro.frame.size.width;
    int maiorLarguraDeTexto = larguraLinha > larguraLetreiro ? larguraLinha : larguraLetreiro;
    
    [view addSubview:letreiro];
    [view addSubview:linha];
    [view addSubview:imageView];
    
    int larguraTotal = tamanhoImagem + maiorLarguraDeTexto;
    
    return CGPointMake(novaOrigem.x + larguraTotal, novaOrigem.y);
}

+(UILabel*) labelWithText: (NSString*) text andStartingAtX: (int) x andY: (int) y {
    return [self labelWithText:text andStartingAtX:x andY:y withFontSize:14];
}

+(UILabel*) labelWithText: (NSString*) text andStartingAtX: (int) x andY: (int) y withFontSize: (int) fontSize {
    UIFont *font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(fontSize)];
    
    CGSize tamanhoLabel = [text sizeWithFont:font];
    
    UILabel *label = [[UILabel alloc] init];
    [label setText: [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    [label sizeToFit];
    [label setFrame:CGRectMake(x, y, tamanhoLabel.width, tamanhoLabel.height)];
    label.backgroundColor = [UIColor colorWithRed:0.0 green:0.1 blue:0.1 alpha:0.0];
    
    label.textColor = [UIColor whiteColor];
    label.font = font;
    
    return label;
}

@end
