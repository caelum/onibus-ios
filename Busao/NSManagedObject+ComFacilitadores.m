//
//  NSManagedObject+ComFacilitadores.m
//  Carangos
//
//  Created by Erich Egert on 4/17/13.
//  Copyright (c) 2013 Starfuckers Inc. All rights reserved.
//

#import "NSManagedObject+ComFacilitadores.h"


@implementation NSManagedObject (ComFacilitadores)

+(NSManagedObject*) detachedManagedObjectWithContext:(NSManagedObjectContext*) context{
    NSEntityDescription *entity = [NSEntityDescription entityForName: NSStringFromClass(self)
                                              inManagedObjectContext:context];
    
    return [[NSManagedObject alloc] initWithEntity:entity
                    insertIntoManagedObjectContext:nil];
}

+(NSManagedObject*) managedObjectWithContext:(NSManagedObjectContext*) context {
    
    return [NSEntityDescription insertNewObjectForEntityForName: NSStringFromClass(self)
                                         inManagedObjectContext: context];
}


+(NSFetchRequest*) createFetch:(NSManagedObjectContext*) context{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =  [NSEntityDescription entityForName: NSStringFromClass(self)
                                               inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    return fetchRequest;
}

+(NSArray*) allWithContext: (NSManagedObjectContext*) ctx {
    NSFetchRequest *fetch = [self createFetch:ctx ];
    
    return [ctx executeFetchRequest:fetch error:nil];
}


@end
