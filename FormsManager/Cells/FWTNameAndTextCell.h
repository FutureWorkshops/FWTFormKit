//
//  FWTNameAndTextCell.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 11/02/2015.
//
//

#import <UIKit/UIKit.h>
#import "FWTTextInputCell.h"
#import "FWTFormCell.h"
#import "FWTPlaceholder.h"
#import "FWTTitle.h"
#import "FWTCellAppearanceProtocol.h"


@interface FWTNameAndTextCell : FWTTextInputCell <FWTPlaceholder, FWTTitle, FWTCellAppearanceProtocol>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextField *textField;

@end
