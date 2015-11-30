//
//  FWTValidationRule.h
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 30/11/2015.
//
//

#import <Foundation/Foundation.h>

@interface FWTRangeValidationRule : NSObject


+(instancetype) ruleWithMinValue:(NSNumber *) minValue maxValue:(NSNumber *) maxValue;


@end
