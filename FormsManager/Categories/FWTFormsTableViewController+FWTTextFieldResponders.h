//
//  FWTFormsTableViewController+FWTTextFieldResponders.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 28/04/2015.
//
//

#import "FWTFormsTableViewController.h"
#import "FWTTextFieldResponderProtocol.h"

@interface FWTFormsTableViewController (FWTTextFieldResponders) <FWTTextFieldResponderChainHandlerProtocol>


-(void) registerTextRespondersInCell:(UITableViewCell *) cell withIndexPath:(NSIndexPath *) indexPath;
-(void) removeTextResponderAtIndexPath:(NSIndexPath *) indexPath;
-(void) removeAllTextResponders;


@end
