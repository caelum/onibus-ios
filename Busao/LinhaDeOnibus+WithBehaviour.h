//
//  LinhaDeOnibus+WithBehaviour.h
//  BusaoSP
//
//  Created by Erich Egert on 7/1/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "LinhaDeOnibus.h"
#import <CoreData/CoreData.h>
#import "Onibus.h"

@interface LinhaDeOnibus (WithBehaviour)

+(void) mudaStatusDeFavoritoParaOnibus: (Onibus*) onibus noContext: (NSManagedObjectContext*) ctx ;

+(LinhaDeOnibus*) linhaFromOnibus: (Onibus*) onibus andContext: (NSManagedObjectContext*) ctx;

+(LinhaDeOnibus*) buscaPorId:(int) identificador noContext: (NSManagedObjectContext*) ctx;

+(NSArray*) todasWithContext: (NSManagedObjectContext*) ctx;
-(NSString*) descricaoSentido;

-(BOOL) favorito;

@end
