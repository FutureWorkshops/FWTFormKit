//
//  FWTCurrencyInputValidatorWithMaxValue.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 13/03/2015.
//
//

#import "FWTCurrencyInputFormatterWithMaxValue.h"

@interface FWTCurrencyInputFormatterWithMaxValue ()

@property (nonatomic) NSString *validatedString;
//@property (nonatomic)

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
    
    long delta =  [self longFromString:string] - [self longFromString:self.validatedString];
    
    if (delta <= [self.maxValue longValue]) {
        return [super formatInputText:string];
    }
    
    return NO;
}

-(BOOL)validateValueString:(NSString *)string withAppendum:(NSNumber *)value
{
    if ([value longValue] <= [self.maxValue longValue]) {
        return [super validateValueString:string withAppendum:value];
    }
    return NO;


}

-(BOOL)validateValueString:(NSString *)string withDeduction:(NSNumber *)value
{
    
    if ([value longValue] <= [self longFromString:string]) {
        return [super validateValueString:string withDeduction:value];
    }
    return NO;

}





@end
