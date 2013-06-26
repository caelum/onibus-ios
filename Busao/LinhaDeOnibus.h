//
//  LinhaDeOnibus.h
//  BusaoSP
//
//  Created by Erich Egert on 6/26/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Onibus.h"

@class TagSelecaoLinhas;

@interface LinhaDeOnibus : NSManagedObject

@property (nonatomic, retain) NSString * codigoGPS;
@property (nonatomic, retain) NSString * destino;
@property (nonatomic, retain) NSNumber * identificador;
@property (nonatomic, retain) NSString * letreiro;
@property (nonatomic, retain) NSString * origem;
@property (nonatomic, retain) TagSelecaoLinhas *tag;

+(void) mudaStatusDeFavoritoParaOnibus: (Onibus*) onibus noContext: (NSManagedObjectContext*) ctx ;

+(LinhaDeOnibus*) linhaFromOnibus: (Onibus*) onibus andContext: (NSManagedObjectContext*) ctx;

+(LinhaDeOnibus*) buscaPorId:(int) identificador noContext: (NSManagedObjectContext*) ctx;

+(NSArray*) todasWithContext: (NSManagedObjectContext*) ctx;
-(NSString*) descricaoSentido;

-(BOOL) favorito;

@end
