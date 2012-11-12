//
//  UIDevice+iPhone.m
//  BusaoSP
//
//  Created by Diego Chohfi on 11/12/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "UIDevice+iPhone.h"

@implementation UIDevice (iPhone)

+ (BOOL) iPhone{
    return [[self currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

@end
