//
//  FWTGenericTableViewCell.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 09/02/2015.
//
//

#import <UIKit/UIKit.h>
#import "FWTStringFormatterProtocol.h"
#import "FWTTextFieldResponderProtocol.h"
#import "FWTFormCell.h"
#import "FWTValidationProtocol.h"
#import "FWTCellValidationErrorDelegate.h"

@interface FWTTextInputCell : FWTFormCell <FWTTextFieldResponderProtocol>

@property (nonatomic) id <FWTTextFieldResponderChainHandlerProtocol> textFieldResponderChainHandler;
@property (nonatomic) id <FWTValidationProtocol> inputValidator;
@property (nonatomic) id <FWTCellValidationErrorDelegate> inputErrorDelegate;

@end

