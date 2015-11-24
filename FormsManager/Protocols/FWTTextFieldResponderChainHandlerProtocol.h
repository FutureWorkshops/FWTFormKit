//
//  FWTTextFieldResponderHandlerProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 28/04/2015.
//
//

#import <Foundation/Foundation.h>

@protocol FWTTextFieldResponderChainHandlerProtocol <NSObject>

- (void) nextResponderForCell:(UITableViewCell *) cell textViewWithTag:(NSUInteger) textFieldTag;
- (BOOL) haveNextResponderTextFieldWithTag:(NSUInteger) textViewTag inCell:(UITableViewCell *) cell;


@end
