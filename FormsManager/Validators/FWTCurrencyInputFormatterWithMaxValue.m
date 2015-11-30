//
//  FWTCurrencyInputValidatorWithMaxValue.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 13/03/2015.
//
//

#import "FWTCurrencyInputFormatterWithMaxValue.h"

@interface FWTCurrencyInputFormatterWithMaxValue ()

@end

@implementation FWTCurrencyInputFormatterWithMaxValue


+(instancetype) currencyInputFormatterWithNumberFormatter:(NSNumberFormatter *) numberFormatter maxValue:(NSNumber *) maxValue
{
    
    FWTCurrencyInputFormatterWithMaxValue *validator  = [FWTCurrencyInputFormatterWithMaxValue new];
    validator.numberFormatter = numberFormatter;
    validator.maxValue = maxValue;
    return validator;
}


#pragma mark - Override

-(BOOL) formatInputText:(NSString *)string
{
    
    long delta =  [self longFromString:string] - [self longFromString:self.formattedString];
    
    if (delta <= [self.maxValue longValue]) {
        return [super formatInputText:string];
    }
    
    return NO;
}

-(BOOL)formatInputString:(NSString *)string withAppendum:(NSNumber *)value
{
    if ([value longValue] <= [self.maxValue longValue]) {
        return [super formatInputString:string withAppendum:value];
    }
    return NO;


}

-(BOOL)formatInputString:(NSString *)string withDeduction:(NSNumber *)value
{
    
    if ([value longValue] <= [self longFromString:string]) {
        return [super formatInputString:string withDeduction:value];
    }
    return NO;

}





@end
