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
