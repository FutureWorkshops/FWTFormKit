//
//  FWTNameAndValueCell.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 06/02/2015.
//
//

#import <UIKit/UIKit.h>
#import "FWTTextInputCell.h"
#import "FWTFormCell.h"
#import "FWTPlaceholder.h"
#import "FWTSubtitle.h"
#import "FWTTitle.h"
#import "FWTInputFormattableCell.h"
#import "FWTInputValidatableCell.h"
#import "FWTTextFieldInputError.h"

@interface FWTNameAndValueCell : FWTTextInputCell <FWTPlaceholder, FWTSubtitle, FWTTitle, FWTInputFormattableCell, FWTInputValidatableCell>

@property (strong, nonatomic) IBOutlet UILabel *titleLable;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (strong, nonatomic) IBOutlet UITextField *valueTextField;

@property (nonatomic) id <FWTStringFormatterProtocol> inputFormatter;
@property (nonatomic) id <FWTTextFieldInputError> inputErrorDelegate;


@end
