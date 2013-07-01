//
//  TagLinhas+WithBevaviour.m
//  BusaoSP
//
//  Created by Erich Egert on 7/1/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "TagLinhas+WithBevaviour.h"
#import "NSManagedObject+ComFacilitadores.h"
#import "LinhaDeOnibus+WithBehaviour.h"


@implementation TagLinhas (WithBevaviour)

+(TagLinhas*) tagSelecaoLinhaParaLinhas: (NSArray*) onibuses andContext: (NSManagedObjectContext*) ctx {
    
    NSArray *ordenadosPorCodigo =
    [onibuses sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        LinhaDeOnibus *o1 = (LinhaDeOnibus*)obj1;
        LinhaDeOnibus *o2 = (LinhaDeOnibus*)obj2;
        
        return [o1.codigoGPS compare:o2.codigoGPS];
    }];
    
    NSMutableString *codigo = [[NSMutableString alloc]init];
    
    TagLinhas *nova = (TagLinhas*)[self detachedManagedObjectWithContext:ctx];
    
    for (LinhaDeOnibus *linha in ordenadosPorCodigo) {
        [codigo appendString:linha.codigoGPS];
        [codigo appendString:@"-"];
        [nova addOnibusesObject:linha];
    }
    
    //TODO buscar ve se já não tem a combinação de codigos!
    nova.codigo = codigo;
    
    return nova;
}



+(NSArray*) todasWithContext:(NSManagedObjectContext*) ctx {
    return [self allWithContext:ctx];
}


@end
