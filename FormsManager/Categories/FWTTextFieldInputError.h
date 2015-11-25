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


@end
