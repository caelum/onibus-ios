//
//  PontoUITableSection.m
//  BusaoSP
//
//  Created by Erich Egert on 6/5/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "PontoUITableSection.h"
#import <QuartzCore/QuartzCore.h>

@interface PontoUITableSection()

@property (nonatomic, strong) void (^selecaoSection) (void);

@end


@implementation PontoUITableSection


-(id) initWithPonto: (Ponto*) ponto andLocalizacaoAtual: (Localizacao*) localizacao andCallback: (void (^)(void)) callback {
    
    CGRect frameTela = [[UIScreen mainScreen] applicationFrame];
    
    if (self = [super initWithFrame:CGRectMake(0, 0, frameTela.size.width, [PontoUITableSection height])]) {
        self.selecaoSection = callback;
        self.backgroundColor = [UIColor grayColor];
        
        self.layer.borderColor = [UIColor colorWithWhite:0.4f alpha:1].CGColor;
        self.layer.borderWidth = 1.0f;
        
        UILabel *labelPonto = [self labelWithText:ponto.descricao
                                   andStartingAtX:5
                                             andY:5
                                     withFontSize:17];
        
        [self addSubview:labelPonto];
        
        NSString *localAtual = [NSString stringWithFormat:@"Distância: %.0fm", [ponto.localizacao distanciaEntrePonto:localizacao]];
        
        UILabel *labelDistancia = [self labelWithText:localAtual
                                       andStartingAtX:5
                                                 andY:labelPonto.frame.size.height + 7
                                         withFontSize:12];
        
        [self addSubview:labelDistancia];
    }
    return self;
}

-(void) executaSelecao {
    self.selecaoSection();
}

-(UILabel*) labelWithText: (NSString*) text andStartingAtX: (int) x andY: (int) y withFontSize: (int) fontSize {
    UIFont *font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(fontSize)];
    
    CGSize tamanhoLabel = [text sizeWithFont:font];
    
    UILabel *label = [[UILabel alloc] init];
    [label setText: [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    [label sizeToFit];
    [label setFrame:CGRectMake(x, y, tamanhoLabel.width, tamanhoLabel.height)];
    label.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    
    label.textColor = [UIColor whiteColor];
    label.font = font;
    
    return label;
}

+(CGFloat) height {
    return 50;
}

@end
