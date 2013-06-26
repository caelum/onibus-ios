//
//  LinhaDeOnibus.m
//  Pods
//
//  Created by Erich Egert on 6/5/13.
//
//

#import "LinhaDeOnibus.h"
#import "NSManagedObject+ComFacilitadores.h"


@implementation LinhaDeOnibus

@dynamic letreiro;
@dynamic identificador;
@dynamic codigoGPS;
@dynamic origem;
@dynamic destino;

+(void) mudaStatusDeFavoritoParaOnibus: (Onibus*) onibus noContext: (NSManagedObjectContext*) ctx {
    if (onibus.favorito) {
        LinhaDeOnibus *favoritado = [self buscaPorId:onibus.identificador noContext:ctx];
        [ctx deleteObject:favoritado];
        onibus.favorito = NO;
    } else {
        [self linhaFromOnibus:onibus andContext:ctx];
        onibus.favorito = YES;
    }
}

+(LinhaDeOnibus*) linhaFromOnibus: (Onibus*) onibus andContext: (NSManagedObjectContext*) ctx {
    LinhaDeOnibus *linha = [self buscaPorId:onibus.identificador noContext:ctx];
    
    if (!linha ) {
        linha = (LinhaDeOnibus*) [self managedObjectWithContext:ctx];
        linha.origem = onibus.sentido.terminalPartida;
        linha.destino = onibus.sentido.terminalSecundario;
        linha.letreiro = onibus.letreiro;
        linha.identificador = [NSNumber numberWithInt:onibus.identificador];
        linha.codigoGPS = onibus.codigoGPS;
    }
    
    return linha;
}

+(LinhaDeOnibus*) buscaPorId:(int) identificador noContext: (NSManagedObjectContext*) ctx{
    NSFetchRequest *fetch = [self createFetch:ctx];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identificador = %d" argumentArray:@[[NSNumber numberWithInt:identificador]]];
    [fetch setPredicate:predicate];
    NSArray *resultado = [ctx executeFetchRequest:fetch error:nil];
    
    if (resultado && [resultado count] >0) {
        return [resultado objectAtIndex:0];
    }
    return nil;
}

+(NSArray*) todasWithContext: (NSManagedObjectContext*) ctx {
    return [self allWithContext:ctx];
}

-(NSString*) descricaoSentido {
    return self.origem;
}

-(NSString*) description {
    return self.letreiro;
}

-(BOOL) favorito {
    return YES;
}

@end
