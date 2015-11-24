//
//  UITextField+FWTInputError.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 10/03/2015.
//
//

#import "UITextField+FWT.h"


@implementation UITextField (FWT)


-(void) inputError
{
    UIColor *textFieldBackgroundColor = self.backgroundColor;
    self.backgroundColor = [UIColor redColor];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = textFieldBackgroundColor;
    } completion:nil];
}

-(void) disable
{
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
}


-(void) enable
{
    self.backgroundColor = [UIColor grayColor];
    self.userInteractionEnabled = YES;
}

@end
