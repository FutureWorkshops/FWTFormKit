//
//  UITextField+FWTInputError.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 10/03/2015.
//
//

#import <UIKit/UIKit.h>
#import "FWTTextFieldInputError.h"
#import "FWTTextFieldEnablerProtocol.h"


@interface UITextField (FWT)

- (void) setTextFieldInputErrorDelegate:(id <FWTTextFieldInputError>) delegate;
- (void) setTextFieldEnablerDelegate:(id <FWTTextFieldEnablerProtocol>) delegate;


-(void) inputError;
-(void) disable;
-(void) enable;




@end
