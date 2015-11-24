//
//  FWTCurrencyInputValidatorWithMaxValue.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 13/03/2015.
//
//

#import "FWTCurrencyInputValidatorWithMaxValue.h"

@interface FWTCurrencyInputValidatorWithMaxValue ()

@property (nonatomic) NSString *validatedString;
//@property (nonatomic)

@end

@implementation FWTCurrencyInputValidatorWithMaxValue


+(instancetype) currencyInputValidatorWithFormatter:(NSNumberFormatter *) numberFormatter maxValue:(NSNumber *) maxValue
{
    
    FWTCurrencyInputValidatorWithMaxValue *validator  = [FWTCurrencyInputValidatorWithMaxValue new];
    validator.inputFormatter = numberFormatter;
    validator.maxValue = maxValue;
    return validator;
}


#pragma mark - Override

-(BOOL) validateText:(NSString *)string
{
    
    long delta =  [self longFromString:string] - [self longFromString:self.validatedString];
    
    if (delta <= [self.maxValue longValue]) {
        return [super validateText:string];
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
