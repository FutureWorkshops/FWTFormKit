//
//  FWTStringLengthValidatonRule.h
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 10/12/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTValidationRule.h"

@interface FWTStringLengthValidatonRule : NSObject <FWTValidationRule>

+(instancetype) ruleWithMaxStringLength:(NSUInteger) maxStringLegth;

@end
