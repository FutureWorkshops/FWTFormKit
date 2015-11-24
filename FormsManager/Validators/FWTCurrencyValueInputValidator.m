//
//  FWTCurrencyValueInputValidator.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 09/03/2015.
//
//

#import "FWTCurrencyValueInputValidator.h"
#import "NSNumberFormatter+FWTNumberFormatter.h"


@interface FWTCurrencyValueInputValidator ()

@property (nonatomic) NSString *validatedString;

@end

@implementation FWTCurrencyValueInputValidator


+(instancetype) currencyInputValidatorWithFormatter:(NSNumberFormatter *) numberFormatter
{
    FWTCurrencyValueInputValidator *validator  = [FWTCurrencyValueInputValidator new];
    validator.inputFormatter = numberFormatter;
    return validator;
}

-(NSNumberFormatter *) inputFormatter
{
    if (!_inputFormatter) {
        _inputFormatter = [NSNumberFormatter numberFormatterForCurrencyWithUserLocaleCurrencySymbol];
    }
    
    return _inputFormatter;
}


-(BOOL) validateText:(NSString *)value
{    
    NSUInteger minimumTextLenght = self.inputFormatter.currencySymbol.length;
    NSNumber *replacedAmount = [self.inputFormatter numberFromString:value];
    
    if (replacedAmount == nil) {
        //Probably non numeric character OR all meaningful digits were deleted.
        if (value.length < minimumTextLenght + 1) {
            self.validatedString = [self.inputFormatter stringFromNumber:@0];
            return YES;
        }
        return NO;
    }

    self.validatedString = [self.inputFormatter stringFromNumber:replacedAmount];
    return YES;
}

-(BOOL) validateValueString:(NSString *) string withAppendum:(NSNumber *)value
{
    long numberLong = [self longFromString:string];
    
    if (numberLong + [value doubleValue] > [self.inputFormatter.maximum doubleValue]) {
        return NO;
    }
    
    NSNumber *number = [NSNumber numberWithLong:numberLong + [value longValue]];
    
    self.validatedString = [self.inputFormatter stringFromNumber:number];

    return YES;
}

-(BOOL) validateValueString:(NSString *) string withDeduction:(NSNumber *)value
{
    
    long numberLong = [self longFromString:string];
    
    if (numberLong < [value doubleValue]) {
        return NO;
    }
    
    NSNumber *number = [NSNumber numberWithLong:numberLong - [value longValue]];
    self.validatedString = [self.inputFormatter stringFromNumber:number];
    
    return YES;
}


-(NSString *) validatedString
{
    if (!_validatedString) {
        _validatedString = [NSString new];
    }
    return _validatedString;
}


// convinience
-(long) longFromString:(NSString *) string
{
    NSNumber *number =[self.inputFormatter numberFromString: string];
    return  [number longValue];
}

@end


