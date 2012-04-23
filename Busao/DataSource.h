//
//  DataSource.h
//  Busao
//
//  Created by Diego Chohfi on 3/30/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataSourceDelegate <NSObject>

- (NSString *) getURL;
- (void) tratarRetorno: (NSMutableArray *) dados;
- (void) problemaComunicacao;

@end

@interface DataSource : NSObject

- (id)initWithDelegate: (id<DataSourceDelegate>) delegate;
- (void)inicializaConexao;

@end
