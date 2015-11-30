//
//  FWTTextFieldInputDelegate.h
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 30/11/2015.
//
//

#import <Foundation/Foundation.h>

@protocol FWTTextFieldInputDelegate <NSObject>

-(void) fwt_textFieldBeginEditing:(UITextField *) textField;
-(void) fwt_textFieldEndEditing:(UITextField *) textField;

@end
