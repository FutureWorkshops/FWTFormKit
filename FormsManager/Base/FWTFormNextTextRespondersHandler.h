//
//  FWTFormTextRespondersHandler.h
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 11/01/2016.
//
//

#import <Foundation/Foundation.h>
#import "FWTFormRespondersChainHadlerProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface FWTFormNextTextRespondersHandler : NSObject  <FWTFormRespondersChainHadlerProtocol>

-(instancetype) initWithTableView:(UITableView *) tableView;

NS_ASSUME_NONNULL_END

@end
