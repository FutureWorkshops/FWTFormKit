//
//  FWTTextFieldEnablerProtocol.h
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 25/11/2015.
//
//

#import <Foundation/Foundation.h>

@protocol FWTTextFieldEnablerProtocol <NSObject>

-(void) setEnableTextField:(UITextField *) textField;
-(void) setDisableTextField:(UITextField *) textField;

@end
