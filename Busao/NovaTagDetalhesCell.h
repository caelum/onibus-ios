//
//  NovaTagDetalhesCell.h
//  BusaoSP
//
//  Created by Erich Egert on 7/1/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NovaTagDetalhesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *nomeTag;

- (IBAction)selecionaHoraInicial:(id)sender;

- (IBAction)selecionaHoraFinal:(id)sender;

+(NSString*) reuseIdentifierAndXibName;

+(NSInteger) rowHeightForCell;

+(void) registerCellXibInTableView: (UITableView*) tableView;

+(NovaTagDetalhesCell*) cellForTableView:(UITableView*) table;

@end
