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
    [self.textFieldResponderChainHandler nextResponderForCell:self textViewWithTag:textField.tag];
    if (![self.textFieldResponderChainHandler haveNextResponderTextFieldWithTag:textField.tag inCell:self]) {
        [textField resignFirstResponder];
    }
    return NO;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    textField.returnKeyType = UIReturnKeyNext;
    
    if ([self.textFieldInputDelegate conformsToProtocol:@protocol(FWTTextFieldInputDelegate)]) {
        [self.textFieldInputDelegate cell:self textFieldBeginEditing: textField];
    }
    
    if ([self.inputErrorDelegate conformsToProtocol:@protocol(FWTTextFieldInputError)]) {
        if([self.inputErrorDelegate cell:self textFieldShouldCleanErrorOnBeginEditing:textField]) {
            [self.inputErrorDelegate cell:self cleanErrorForInputTextFeild:textField];
        }
    }
    
}


-(BOOL)shoudRegisterAsTextResponder
{
    return YES;
}

-(NSArray *)textFieldRespondersTags
{
    NSAssert(NO, @"Override in subclass");
    return nil;
}


@end
