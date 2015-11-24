//
//  FWTFormCell.h
//  FWTCalculator
//
//  Created by Yevgeniy Prokoshev on 19/11/2015.
//  Copyright © 2015 Yevgeniy Prokoshev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWTCellAppearanceProtocol.h"

@interface FWTFormCell : UITableViewCell <FWTCellAppearanceProtocol>

@property (nonatomic, readonly) CGFloat contentMargin;

@end
