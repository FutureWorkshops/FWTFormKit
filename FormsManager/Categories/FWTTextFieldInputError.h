//
//  FWTTextFieldInputError.h
//  FWTTextFieldInputError
//
//  Created by Yevgeniy Prokoshev on 25/11/2015.
//
//

#import <Foundation/Foundation.h>

@protocol FWTTextFieldInputError <NSObject>

-(void) cell:(id) sender generateInputErrorInTextField:(UITextField *) textField;
-(BOOL) cell:(id) cell textFieldShouldCleanErrorOnBeginEditing:(UITextField *) textField;
-(BOOL) cell:(id) cell textFieldShouldCleanErrorOnEndEditing:(UITextField *) textField;

-(void) cell:(id) cell cleanErrorForInputTextFeild:(UITextField *) textField;


@end
