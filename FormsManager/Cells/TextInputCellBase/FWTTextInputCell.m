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
    [self.textFieldResponderChainHandler nextResponderForCell:self];
    if (![self.textFieldResponderChainHandler haveNextResponderForCell:self]) {
        [textField resignFirstResponder];
    }
    return NO;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    textField.returnKeyType = UIReturnKeyNext;
}


-(BOOL)shoudRegisterAsTextResponder
{
    return YES;
}

-(UITextField *)nextTextFieldResponder
{
    NSAssert(NO, @"Override in subclass");
    return nil;
}


@end
