//
//  FWTNameAndLableCell.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 09/02/2015.
//
//

#import <UIKit/UIKit.h>
#import "FWTTextInputCell.h"
#import "FWTFormCell.h"
#import "FWTAccessoryView.h"
#import "FWTTitle.h"
#import "FWTCellAppearanceProtocol.h"

@interface FWTNameAndLabelCell : FWTFormCell <FWTAccessoryView, FWTTitle,FWTCellAppearanceProtocol>

@property (strong, nonatomic) IBOutlet UIImageView *accessoryImageView;
@property (strong, nonatomic) IBOutlet UILabel *itemTitleLable;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;

@end
