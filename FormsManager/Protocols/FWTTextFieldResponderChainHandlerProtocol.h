//
//  FWTTextFieldResponderHandlerProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 28/04/2015.
//
//

#import <Foundation/Foundation.h>

@protocol FWTTextFieldResponderChainHandlerProtocol <NSObject>

- (void) nextResponderForCell:(UITableViewCell *) cell;
- (BOOL) haveNextResponderForCell:(UITableViewCell *) cell;
- (void) registerNextRespondersInCell:(UITableViewCell *) cell;
- (void) removeNextResponderForCell:(UITableViewCell *) cell;
- (void) removeAllResponders;

@end
