//
//  FWTGenericTableViewCell.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 09/02/2015.
//
//

#import "FWTTextInputCell.h"
#import "NSNumberFormatter+FWTNumberFormatter.h"


@interface FWTTextInputCell () <UITextFieldDelegate>

@end

@implementation FWTTextInputCell


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textFieldResponderChainHandler selectNextResponderForCell:self];
    return NO;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    textField.returnKeyType = UIReturnKeyNext;
}


-(UITextField *)nextTextFieldResponder
{
    NSAssert(NO, @"Override in subclass");
    return nil;
}


@end
