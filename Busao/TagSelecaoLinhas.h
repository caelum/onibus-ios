//
//  TagSelecaoLinhas.h
//  Pods
//
//  Created by Erich Egert on 6/26/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LinhaDeOnibus;

@interface TagSelecaoLinhas : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * codigo;
@property (nonatomic, retain) NSSet *onibuses;
@end

@interface TagSelecaoLinhas (CoreDataGeneratedAccessors)

- (void)addOnibusesObject:(LinhaDeOnibus *)value;
- (void)removeOnibusesObject:(LinhaDeOnibus *)value;
- (void)addOnibuses:(NSSet *)values;
- (void)removeOnibuses:(NSSet *)values;

@end
