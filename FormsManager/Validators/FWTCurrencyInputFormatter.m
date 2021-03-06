//
//  FWTCurrencyValueInputValidator.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 09/03/2015.
//
//

#import "FWTCurrencyInputFormatter.h"
#import "NSNumberFormatter+FWTNumberFormatter.h"


@interface FWTCurrencyInputFormatter ()

@property (nonatomic) NSString *formattedString;

@end

@implementation FWTCurrencyInputFormatter


+(instancetype) currencyInputFormatterWithDefaultNumberFormatter {
 
    FWTCurrencyInputFormatter *inputFormatter  = [FWTCurrencyInputFormatter new];
    return inputFormatter;
}


+(instancetype) currencyInputFormatterWithNumberFormatter:(NSNumberFormatter *) numberFormatter
{
    FWTCurrencyInputFormatter *validator  = [FWTCurrencyInputFormatter new];
    validator.numberFormatter = numberFormatter;
    return validator;
}

-(NSNumberFormatter *) numberFormatter
{
    if (!_numberFormatter) {
        _numberFormatter = [NSNumberFormatter numberFormatterForCurrencyWithUserLocaleCurrencySymbol];
    }
    
    return _numberFormatter;
}


-(BOOL) formatInputText:(NSString *)value
{    
    NSUInteger minimumTextLenght = self.numberFormatter.currencySymbol.length;
    NSNumber *replacedAmount = [self.numberFormatter numberFromString:value];
    
    if (replacedAmount == nil) {
        //Probably non numeric character OR all meaningful digits were deleted.
        if (value.length < minimumTextLenght + 1) {
            self.formattedString = nil; //[self.inputFormatter stringFromNumber:@0];
            return YES;
        }
        return NO;
    }

    self.formattedString = [self.numberFormatter stringFromNumber:replacedAmount];
    return YES;
}

-(BOOL) formatInputString:(NSString *) string withAppendum:(NSNumber *)value
{
    long numberLong = [self longFromString:string];
    
    if (numberLong + [value doubleValue] > [self.numberFormatter.maximum doubleValue]) {
        return NO;
    }
    
    NSNumber *number = [NSNumber numberWithLong:numberLong + [value longValue]];
    
    self.formattedString = [self.numberFormatter stringFromNumber:number];

    return YES;
}

-(BOOL) formatInputString:(NSString *) string withDeduction:(NSNumber *)value
{
    
    long numberLong = [self longFromString:string];
    
    if (numberLong < [value doubleValue]) {
        return NO;
    }
    
    NSNumber *number = [NSNumber numberWithLong:numberLong - [value longValue]];
    self.formattedString = [self.numberFormatter stringFromNumber:number];
    
    return YES;
}


-(NSString *) formattedString
{
    if (!_formattedString) {
        _formattedString = [NSString new];
    }
    return _formattedString;
}


// convinience
-(long) longFromString:(NSString *) string
{
    NSNumber *number =[self.numberFormatter numberFromString: string];
    return  [number longValue];
}

@end


