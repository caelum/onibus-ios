//
//  LegendaOnibus.m
//  BusaoSP
//
//  Created by Erich Egert on 6/4/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "LegendaOnibus.h"
#import "UILabel+DetailLabel.h"

@implementation LegendaOnibus

-(id) initWithOnibuses: (NSArray*) onibuses andImagens:(NSArray*) imagemsVeiculos andLargura: (float) width {
    CGRect rectFundo = CGRectMake(0, 0, width, 30);
    
    if (self = [super initWithFrame:rectFundo]) {
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.1 blue:0.1 alpha:0.75];
        
        CGPoint origem = CGPointMake(0, 0);
        
        for (int i=0; i< [onibuses count]; i++) {
            Onibus *onibus = [onibuses objectAtIndex:i];
            UIImage *imagem = [imagemsVeiculos objectAtIndex:i];
            
            origem = [self addOnibus:onibus andImage:imagem andStartingAt:origem inView:self];
        }
        
        self.contentSize = CGSizeMake(origem.x+10,30);
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];

    }
    return self;
}

-(CGPoint) addOnibus: (Onibus*) onibus andImage: (UIImage*) imagem andStartingAt: (CGPoint) origem inView: (UIView*) view{
    int tamanhoImagem = imagem.size.width;
    CGPoint novaOrigem = CGPointMake(origem.x+5, origem.y);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(novaOrigem.x, 0, imagem.size.width, imagem.size.height)];
    [imageView setImage:imagem];
    
    UILabel *letreiro = [UILabel labelWithText:onibus.letreiro
                                         andStartingAtX:novaOrigem.x + tamanhoImagem
                                                   andY:novaOrigem.y];
    
    UILabel *linha = [UILabel labelWithText:[onibus.sentido description]
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

@end
