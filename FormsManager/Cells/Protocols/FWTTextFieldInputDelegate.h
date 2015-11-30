//
//  FWTTextFieldInputDelegate.h
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 30/11/2015.
//
//

#import <Foundation/Foundation.h>

@protocol FWTTextFieldInputDelegate <NSObject>

-(void) cell:(id) cell textFieldBeginEditing:(UITextField *) textField;

@optional
-(void) cell:(id) cell textFieldEndEditing:(UITextField *) textField;

@end
