//
//  FWTFormsTableViewController+FWTObserverManager.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 20/05/2015.
//
//

#import "FWTFormsTableViewController.h"
#import "FWTKVO.h"
#import "FWTKVOProtocol.h"

@interface FWTFormsTableViewController (FWTObserverManager) <FWTKVOProtocol>

// observers
-(void) registerObserverForCell:(UITableViewCell *) cell withIndexPath:(NSIndexPath *) indexPath forKeyPath:(NSString *) keyPath;
-(void) removeObserverForCellAtIndexPath:(NSIndexPath *) indexPath;
-(void) removeObserversForCells;


@end
