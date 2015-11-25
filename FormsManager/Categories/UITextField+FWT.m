//
//  UITextField+FWTInputError.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 10/03/2015.
//
//

#import "UITextField+FWT.h"
#import <objc/runtime.h>

NSString * const FWTTextFieldInputErrorDelegate = @"FWTTextFieldInputErrorDelegate";
NSString * const FWTTextFieldEnablerDelegate = @"FWTTextFieldEnablerDelegate";


@implementation UITextField (FWT)


- (void)setTextFieldInputErrorDelegate:(id <FWTTextFieldInputError>) delegate
{
    objc_setAssociatedObject(self, &FWTTextFieldInputErrorDelegate, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id <FWTTextFieldInputError> ) textFieldInputErrorDelegate
{
    id textFieldInputError = objc_getAssociatedObject(self, &FWTTextFieldInputErrorDelegate);
    
    if (textFieldInputError) {
        return textFieldInputError;
    }
    
    else {
        return nil;
    }
}


- (void) setTextFieldEnablerDelegate:(id <FWTTextFieldEnablerProtocol>) delegate
{
    objc_setAssociatedObject(self, &FWTTextFieldEnablerDelegate, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id <FWTTextFieldEnablerProtocol> ) textFieldEnablerDelegate
{
    id textFieldEnabler = objc_getAssociatedObject(self, &FWTTextFieldEnablerDelegate);
    
    if (textFieldEnabler) {
        return textFieldEnabler;
    }
    else {
        return nil;
    }
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wselector"
-(void) inputError
{
    id textFieldInpurErrorDelegate = [self textFieldInputErrorDelegate];
    if ([textFieldInpurErrorDelegate conformsToProtocol:@protocol(FWTTextFieldInputError)]) {
        [textFieldInpurErrorDelegate performSelector:@selector(inputErrorInTextField:) withObject:self];
    }

}

-(void) disable
{
    id textFieldEnablerDelegate = [self textFieldEnablerDelegate];
    if ([textFieldEnablerDelegate conformsToProtocol:@protocol(FWTTextFieldEnablerProtocol)]) {
        [textFieldEnablerDelegate performSelector:@selector(setDisableTextField:) withObject:self];
    }
}


-(void) enable
{
    id textFieldEnablerDelegate = [self textFieldEnablerDelegate];
    if ([textFieldEnablerDelegate conformsToProtocol:@protocol(FWTTextFieldEnablerProtocol)]) {
        [textFieldEnablerDelegate performSelector:@selector(setEnableTextField:) withObject:self];
    }
}

#pragma clang diagnostic pop

@end
