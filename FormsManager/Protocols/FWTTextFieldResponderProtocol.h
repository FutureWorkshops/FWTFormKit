//
//  FWTTextFieldResponderProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 28/04/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTTextFieldResponderChainHandlerProtocol.h"

@protocol FWTTextFieldResponderProtocol <NSObject>

@required
@property (nonatomic) id <FWTTextFieldResponderChainHandlerProtocol> textFieldResponderChainHandler;
- (NSArray *) textFieldRespondersTags;
- (BOOL) shoudRegisterAsTextResponder;


@end
