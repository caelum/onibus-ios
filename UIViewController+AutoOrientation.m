//
//  UIViewController+AutoOrientation.m
//  BusaoSP
//
//  Created by Diego Chohfi on 11/12/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "UIViewController+AutoOrientation.h"

@implementation UIViewController (AutoOrientation)

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self changeViewIfOnLandscape: toInterfaceOrientation];
}
- (void) changeViewIfOnLandscape: (UIInterfaceOrientation) orientation{
    if(![UIDevice iPhone])
        return;
    NSString *xibName = [NSString stringWithFormat:@"%@", NSStringFromClass([self class])];
    if( UIInterfaceOrientationIsLandscape(orientation) ){
        xibName = [NSString stringWithFormat:@"%@-landscape", NSStringFromClass([self class])];
    }
    NSString *fileName = [[NSBundle mainBundle] pathForResource:xibName ofType:@"nib"];
    bool exists = [[NSFileManager defaultManager] fileExistsAtPath:fileName];
    
    if(exists){
        [[NSBundle mainBundle] loadNibNamed:xibName
                                      owner:self
                                    options:nil];
        [self viewDidLoad];
    }
}
@end
