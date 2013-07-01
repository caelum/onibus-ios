//
//  TagLinhas.h
//  BusaoSP
//
//  Created by Erich Egert on 7/1/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LinhaDeOnibus;

@interface TagLinhas : NSManagedObject

@property (nonatomic, retain) NSString * codigo;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSDate * horarioInicio;
@property (nonatomic, retain) NSDate * horarioFim;
@property (nonatomic, retain) NSSet *onibuses;
@end

@interface TagLinhas (CoreDataGeneratedAccessors)

- (void)addOnibusesObject:(LinhaDeOnibus *)value;
- (void)removeOnibusesObject:(LinhaDeOnibus *)value;
- (void)addOnibuses:(NSSet *)values;
- (void)removeOnibuses:(NSSet *)values;

@end
