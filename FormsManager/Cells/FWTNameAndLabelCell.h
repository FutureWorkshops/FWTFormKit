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
#include "FWTTitle.h"

@interface FWTNameAndLabelCell : FWTFormCell <FWTAccessoryView, FWTTitle>

@property (strong, nonatomic) IBOutlet UIImageView *accessoryImageView;
@property (strong, nonatomic) IBOutlet UILabel *itemTitleLable;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;

@end
