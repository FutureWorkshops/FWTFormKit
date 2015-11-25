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

- (void) setTextFieldEnablerDelegate:(id <FWTTextFieldEnablerProtocol>) delegate;

-(void) disable;
-(void) enable;




@end
