//
//  FWTValidationRule.m
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 30/11/2015.
//
//

#import "FWTRangeValidationRule.h"



@interface FWTRangeValidationRule ()

@property (nonatomic) NSNumber *minValue;
@property (nonatomic) NSNumber *maxValue;

@end

@implementation FWTRangeValidationRule

+(instancetype) ruleWithMinValue:(NSNumber *)minValue maxValue:(NSNumber *)maxValue
{
    FWTRangeValidationRule *rule = [FWTRangeValidationRule new];
    rule.minValue = minValue;
    rule.maxValue = maxValue;
    return rule;
}


-(BOOL) evaluateWithNumber:(NSNumber *) number
{
    return <#expression#>
    
}

@end
