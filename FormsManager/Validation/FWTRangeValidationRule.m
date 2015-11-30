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


-(BOOL) evaluateWithObject:(id)object
{
    if ([object respondsToSelector:@selector(compare:)] && [object isKindOfClass:[NSNumber class]]) {
    
        NSComparisonResult leftOperandComparison = [object compare:self.minValue];
        NSComparisonResult rightOperandComparison = [object compare:self.maxValue];
        return ((leftOperandComparison== NSOrderedSame || leftOperandComparison == NSOrderedDescending) && (rightOperandComparison==NSOrderedSame || rightOperandComparison == NSOrderedAscending));
    }
    
    return NO;
}

@end
