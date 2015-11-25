//
//  FWTNameAndSwitchCell.h
//  FWTNameAndSwitchCell
//
//  Created by Yevgeniy Prokoshev on 06/02/2015.
//
//

#import <UIKit/UIKit.h>
#import "FWTFormCell.h"
#include "FWTTitle.h"

@interface FWTNameAndSwitchCell : FWTFormCell <FWTTitle>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UISwitch *switchSelector;




@end
