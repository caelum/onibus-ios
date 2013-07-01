//
//  ListaTagsController.m
//  BusaoSP
//
//  Created by Erich Egert on 7/1/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "ListaTagsController.h"
#import "TagLinhas+WithBevaviour.h"

@interface ListaTagsController ()

@property(nonatomic, strong) NSArray *tags;

@end

@implementation ListaTagsController


- (void)viewDidLoad{
    [super viewDidLoad];
}

-(void) viewDidAppear:(BOOL)animated {
    self.tags = [TagLinhas todasWithContext:[self context]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tags count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    if (!cell) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    TagLinhas *tag = [self.tags objectAtIndex:indexPath.row];
    cell.textLabel.text = tag.nome;
    return cell;
}

@end
