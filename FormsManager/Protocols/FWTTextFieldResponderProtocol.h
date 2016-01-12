//
//  FWTTextFieldResponderProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 28/04/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTFormRespondersChainHadlerProtocol.h"

@protocol FWTTextFieldResponderProtocol <NSObject>

@required
@property (nonatomic) id <FWTFormRespondersChainHadlerProtocol> textFieldResponderChainHandler;
- (UITextField *) nextTextFieldResponder;

@end
