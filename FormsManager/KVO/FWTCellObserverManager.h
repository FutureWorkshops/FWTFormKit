//
//  FWTCellObserverManager.h
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 30/11/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTKVO.h"
#import "FWTKVOProtocol.h"
#import "FWTObserverDelegate.h"

@interface FWTCellObserverManager : NSObject

@property (nonatomic,readonly) NSDictionary *observedCells; // cell registered for KVO observation

-(instancetype) initWithObserverDelegate:(id <FWTObserverDelegate>) delegate;

// observers
-(void) registerObserverForCell:(UITableViewCell *) cell withIndexPath:(NSIndexPath *) indexPath forKeyPath:(NSString *) keyPath;
-(void) removeObserverForCellAtIndexPath:(NSIndexPath *) indexPath;
-(void) removeObserversForCells;


@end
