//
//  OnibusInfo.h
//  BusaoSP
//
//  Created by Erich Egert on 6/22/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OnibusInfo <NSObject>

-(NSString*) letreiro;
-(NSString*) descricaoSentido;
-(BOOL) favorito;
-(NSString*) codigoGPS;

@end
