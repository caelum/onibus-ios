//
//  NSManagedObject+ComFacilitadores.h
//  Carangos
//
//  Created by Erich Egert on 4/17/13.
//  Copyright (c) 2013 Starfuckers Inc. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (ComFacilitadores)

+(NSManagedObject*) detachedManagedObjectWithContext:(NSManagedObjectContext*) context;
+(NSManagedObject*) managedObjectWithContext:(NSManagedObjectContext*) context;
+(NSFetchRequest*) createFetch:(NSManagedObjectContext*) context;
+(NSArray*) allWithContext: (NSManagedObjectContext*) ctx;


@end
