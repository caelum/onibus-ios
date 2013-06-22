//
//  LinhaDeOnibus.h
//  Pods
//
//  Created by Erich Egert on 6/5/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Onibus.h"
#import "OnibusInfo.h"


@interface LinhaDeOnibus : NSManagedObject<OnibusInfo>

@property (nonatomic, retain) NSString * letreiro;
@property (nonatomic, retain) NSNumber * identificador;
@property (nonatomic, retain) NSString * codigoGPS;
@property (nonatomic, retain) NSString * origem;
@property (nonatomic, retain) NSString * destino;

+(void) mudaStatusDeFavoritoParaOnibus: (Onibus*) onibus noContext: (NSManagedObjectContext*) ctx;

+(NSArray*) todasWithContext: (NSManagedObjectContext*) ctx;

@end
