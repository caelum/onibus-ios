//
//  NSStringWithMaxSize.m
//  Busao
//
//  Created by Diego Chohfi on 4/9/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "NSStringWithMaxSize.h"

@implementation NSStringWithMaxSize
@synthesize maxWidth, defaultFont, sufix;

+ (NSString *) removeExtraFromString: (NSString *) string withMaxWidth: (float) maxWidth{
    return [self removeExtraFromString:string withMaxWidth:maxWidth andFont: [UIFont boldSystemFontOfSize:18]];
}

+ (NSString *) removeExtraFromString: (NSString *) string withMaxWidth: (float) maxWidth andFont: (UIFont *) font{
    return [self removeExtraFromString:string withMaxWidth:maxWidth andFont:font sufixIfNeeded:@"..."];
}

+ (NSString *) removeExtraFromString: (NSString *) string withMaxWidth: (float) maxWidth andFont: (UIFont *) font sufixIfNeeded: (NSString *) sufix{
    NSStringWithMaxSize *stringWithMaxSize = [[NSStringWithMaxSize alloc] init];
    stringWithMaxSize.maxWidth = maxWidth;
    stringWithMaxSize.defaultFont = font;
    stringWithMaxSize.sufix = sufix;
    return [stringWithMaxSize removeExtraFromString:string];    
}

- (NSString *) removeExtraFromString: (NSString *) string{
    float maxWidthMinusDots = maxWidth - [sufix sizeWithFont:defaultFont].width;
    
    if([string sizeWithFont:defaultFont].width < maxWidthMinusDots)
        return string;
    
    NSMutableString *newString = [[NSMutableString alloc] init];
    int currentLetter = 0;
    while([newString sizeWithFont:defaultFont].width < maxWidthMinusDots){
        [newString appendString:[string substringWithRange:NSMakeRange(currentLetter, 1)]];
        currentLetter++;
    }
    return [NSString stringWithFormat:@"%@%@", newString, sufix];
}

@end
