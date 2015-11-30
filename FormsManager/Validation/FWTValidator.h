//
//  FWTValidator.h
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 30/11/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTValidationProtocol.h"

@interface FWTValidator : NSObject <FWTValidationProtocol>

-(instancetype) initWithValidationRules:(NSArray *) validationRules numberFormatter:(NSNumberFormatter *)numberFormatter;

@end
