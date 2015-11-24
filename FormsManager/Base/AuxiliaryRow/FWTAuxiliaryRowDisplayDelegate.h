//
//  FWTAuxiliaryRowDisplayDelegate.h
//  FWTCalculator
//
//  Created by Yevgeniy Prokoshev on 20/11/2015.
//  Copyright © 2015 Yevgeniy Prokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWTAuxiliaryRowProtocol.h"

@class FWTFormAppearanceManager;

@interface FWTAuxiliaryRowDisplayDelegate : NSObject <FWTAuxiliaryRowProtocol>

-(instancetype _Nonnull) initWithTableView:(UITableView * _Nonnull) tableView appearanceManager:(FWTFormAppearanceManager *_Nonnull) appearanceManager;

@end
