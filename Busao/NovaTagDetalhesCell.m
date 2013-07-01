//
//  NovaTagDetalhesCell.m
//  BusaoSP
//
//  Created by Erich Egert on 7/1/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "NovaTagDetalhesCell.h"
#import "TagLinhas+WithBevaviour.h"

@interface NovaTagDetalhesCell()

@property(nonatomic,weak) TagLinhas *novaTag;

@end

@implementation NovaTagDetalhesCell

-(void)configuraParaTag: (TagLinhas*) tag {
    self.novaTag = tag;
}

- (IBAction)editaNomeNovaTag:(id)sender {
    self.novaTag.nome = self.nomeTag.text;
}

+(NSInteger) rowHeightForCell {
    return 170;
}

+(NSString*) reuseIdentifierAndXibName {
    static NSString* idenfifier = @"NovaTagDetalhesCell";
    
    return idenfifier;
}

+(NovaTagDetalhesCell*) cellForTableView:(UITableView*) table {
    return (NovaTagDetalhesCell*) [table dequeueReusableCellWithIdentifier: [self reuseIdentifierAndXibName]];
}

+(void) registerCellXibInTableView: (UITableView*) tableView {
    [tableView registerNib: [UINib nibWithNibName:[self reuseIdentifierAndXibName] bundle:nil]
    forCellReuseIdentifier: [self reuseIdentifierAndXibName]];
}

- (IBAction)selecionaHoraInicial:(id)sender {
    //TODO
}

- (IBAction)selecionaHoraFinal:(id)sender {
    //TODO
}
@end
