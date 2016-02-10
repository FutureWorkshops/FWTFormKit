//
//  FWTFormNextRespondersManager.h
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 21/12/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTTextFieldResponderProtocol.h"

@interface FWTFormNextRespondersManager : NSObject <FWTTextFieldResponderChainHandlerProtocol>

NS_ASSUME_NONNULL_BEGIN

-(instancetype) initWithTableView:(UITableView * _Nonnull) tableView;


NS_ASSUME_NONNULL_END
@end
