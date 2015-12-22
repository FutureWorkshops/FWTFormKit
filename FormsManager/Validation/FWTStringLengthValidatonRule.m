//
//  FWTStringLengthValidatonRule.m
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 10/12/2015.
//
//

#import "FWTStringLengthValidatonRule.h"


@interface FWTStringLengthValidatonRule ()

@property (nonatomic) NSUInteger maxStringLength;

@end

@implementation FWTStringLengthValidatonRule 

+(instancetype)ruleWithMaxStringLength:(NSUInteger)maxStringLegth
{
    FWTStringLengthValidatonRule *rule = [FWTStringLengthValidatonRule new];
    rule.maxStringLength = maxStringLegth;
    
    return rule;
}

-(BOOL)evaluateWithValue:(id)value
{
    if ([value isKindOfClass:[NSString class]]) {
        NSString *stringValue  = value;
        return (stringValue.length <= self.maxStringLength && stringValue.length > 0);
    }
    return NO;
}

@end
