//
//  UILabel+DetailLabel.h
//  Busao
//
//  Created by Diego Chohfi on 4/5/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DetailLabel)

+ (UILabel *) detailLabelWithText: (NSString *) texto withCentralization: (BOOL) centralized;

+(UILabel*) labelWithText: (NSString*) text andStartingAtX: (int) x andY: (int) y;

+(UILabel*) labelWithText: (NSString*) text andStartingAtX: (int) x andY: (int) y withFontSize: (int) fontSize;

@end
