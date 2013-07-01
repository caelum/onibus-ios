//
//  LinhaDeOnibus.h
//  BusaoSP
//
//  Created by Erich Egert on 7/1/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LinhaDeOnibus : NSManagedObject

@property (nonatomic, retain) NSString * codigoGPS;
@property (nonatomic, retain) NSString * destino;
@property (nonatomic, retain) NSNumber * identificador;
@property (nonatomic, retain) NSString * letreiro;
@property (nonatomic, retain) NSString * origem;

@end
