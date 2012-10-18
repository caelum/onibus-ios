//
//  Sentido.h
//  BusaoSP
//
//  Created by Erich Egert on 10/17/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sentido : NSObject

//@property(nonatomic, readonly) int codigo;
@property(nonatomic, readonly) NSString *terminalPartida;
@property(nonatomic, readonly) NSString *terminalSecundario;
@property(nonatomic, readonly) BOOL circular;


@end
