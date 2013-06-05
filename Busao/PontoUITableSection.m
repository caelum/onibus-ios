//
//  PontoUITableSection.m
//  BusaoSP
//
//  Created by Erich Egert on 6/5/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "PontoUITableSection.h"

@interface PontoUITableSection()

@property (nonatomic, strong) void (^selecaoSection) (void);

@end


@implementation PontoUITableSection


-(id) initWithPonto: (Ponto*) ponto andLocalizacaoAtual: (Localizacao*) localizacao andCallback: (void (^)(void)) callback {
    
    CGRect frameTela = [[UIScreen mainScreen] applicationFrame];
    
    if (self = [super initWithFrame:CGRectMake(0, 0, frameTela.size.width, [PontoUITableSection height])]) {
        self.selecaoSection = callback;
        
        UILabel *labelPonto = [self labelWithText:ponto.descricao andStartingAtX:5 andY:5 withFontSize:15];
        [self addSubview:labelPonto];
        
        NSString *localAtual = [NSString stringWithFormat:@"Distância: %.0fm", [ponto.localizacao distanciaEntrePonto:localizacao]];
        UILabel *labelDistancia = [self labelWithText:localAtual andStartingAtX:5 andY:25 withFontSize:12];
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
    return 45;
}

-(CGGradientRef) verticalGradientWithStartColor: (UIColor*) startColor andMiddleColor: (UIColor*) middleColor andEndColor: (UIColor*) endColor {
    CGFloat *startColorComponents = (CGFloat *)CGColorGetComponents([startColor CGColor]);
    CGFloat *middleColorComponents = (CGFloat *)CGColorGetComponents([middleColor CGColor]);
    CGFloat *endColorComponents = (CGFloat *)CGColorGetComponents([endColor CGColor]);
    
    CGFloat colorComponents[12] = {
        startColorComponents[0],
        startColorComponents[1],
        startColorComponents[2],
        startColorComponents[3],
        middleColorComponents[0],
        middleColorComponents[1],
        middleColorComponents[2],
        middleColorComponents[3],
        endColorComponents[0],
        endColorComponents[1],
        endColorComponents[2],
        endColorComponents[3],
    };
    

    CGFloat locations[3] = { 0.05f, 0.45f, 0.95f };
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef treeStepsGradient = CGGradientCreateWithColorComponents(colorSpace, colorComponents, locations, 3);
    CGColorSpaceRelease(colorSpace);
    
    return treeStepsGradient;
};

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *start = [UIColor colorWithRed:2.0/255 green:90.0/255 blue:170.0/255 alpha:1];
    
    CGGradientRef gradient = [self verticalGradientWithStartColor:start andMiddleColor:start andEndColor:[UIColor blueColor]];
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(self.bounds), 0.0);
    CGPoint endPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds));
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, nil);
    

    CGGradientRelease(gradient);
}



@end
