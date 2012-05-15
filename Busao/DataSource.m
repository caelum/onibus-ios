//
//  DataSource.m
//  Busao
//
//  Created by Diego Chohfi on 3/30/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "DataSource.h"

@interface DataSource()

@property(nonatomic, unsafe_unretained) id<DataSourceDelegate> delegate;
@property(nonatomic, strong) NSURLConnection *connection;
@property(nonatomic, strong) NSMutableData *mutableData;

@end

@implementation DataSource
@synthesize connection, mutableData, delegate;

- (id)initWithDelegate: (id<DataSourceDelegate>) _delegate {
    self = [super init];
    if (self) {
        self.delegate = _delegate;
    }
    return self;
}

- (void)inicializaConexao {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    if(connection){
        [connection cancel];
    }
    
    NSURLRequest *request= [NSURLRequest requestWithURL:[NSURL URLWithString:[delegate getURL]]
                    cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    mutableData = [NSMutableData data];
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

- (void)connection:(NSURLConnection *)_connection didReceiveData:(NSData *)data{
    if(_connection == connection){
        [mutableData appendData:data];
    }
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)_connection{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    if (_connection == connection){
        NSError* error;
        NSMutableArray *resultados = [NSJSONSerialization JSONObjectWithData:mutableData
                        options:NSJSONReadingMutableContainers error:&error];
        mutableData = nil;
        connection = nil;
        if(!error){
            [delegate tratarRetorno:resultados];
            return;
        }
    }
    [delegate problemaComunicacao];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Error: %@ %@", error, [error userInfo]);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [delegate problemaComunicacao];
}

@end
