//
//  TagLinhas+WithBevaviour.h
//  BusaoSP
//
//  Created by Erich Egert on 7/1/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "TagLinhas.h"
#import <CoreData/CoreData.h>

@interface TagLinhas (WithBevaviour)

+(TagLinhas*) tagSelecaoLinhaParaLinhas: (NSArray*) onibuses andContext: (NSManagedObjectContext*) ctx;

+(NSArray*) todasWithContext:(NSManagedObjectContext*) ctx;

@end
