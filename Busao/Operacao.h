//
//  Operacao.h
//  BusaoSP
//
//  Created by Erich Egert on 10/17/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Operacao : NSObject

@property(nonatomic, readonly) NSString *diaUtil;
@property(nonatomic, readonly) NSString *sabado;
@property(nonatomic, readonly) NSString *domingo;

-(NSString*) horarioDiaUtil;
-(NSString*) horarioSabado;
-(NSString*) horarioDomingo;

@end
