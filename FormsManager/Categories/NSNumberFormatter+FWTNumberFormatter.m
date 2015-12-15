//
//  NSNumberFormatter+FWTNumberFormatter.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 15/01/2015.
//
//

#import "NSNumberFormatter+FWTNumberFormatter.h"

@implementation NSNumberFormatter (FWTNumberFormatter)


+(instancetype) numberFormatterForCurrencyWithUserLocaleCurrencySymbol
{
    static NSNumberFormatter *_numberFormatter;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSString *sym = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
        _numberFormatter = [NSNumberFormatter numberFormatterForAmountInputWithCurrencySymbol:sym];
    });
    
    return _numberFormatter;
}

+ (instancetype) numberFormatterForAmountInputWithCurrencySymbol:(NSString *) currencySymbol
{
    
    NSNumberFormatter * _numberFormatter = [[NSNumberFormatter alloc] init];
    [_numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [_numberFormatter setLenient:YES];
    [_numberFormatter setGeneratesDecimalNumbers:NO];
    [_numberFormatter setCurrencySymbol:currencySymbol];
    _numberFormatter.maximumFractionDigits = 0;
    _numberFormatter.maximum = @1000000000;

    return _numberFormatter;
}

+(instancetype) numberFormatterForAmountLabelWithLocalCurrencySymbolWithMeasurmentUnitString:(NSString *) measurmentUnitString
{
    static NSNumberFormatter *_numberFormatter;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _numberFormatter = [NSNumberFormatter numberFormatterWithDecimalFormattingAndCurrencySymbol:[NSNumberFormatter currencySymbolForCurrentUserLocale]];
        
    });
    
    [_numberFormatter setPositiveFormat:[NSString stringWithFormat:@"¤#,##0.#%@", measurmentUnitString]];

    return _numberFormatter;
}

+(instancetype) numberFormatterWithDecimalFormattingAndCurrencySymbol:(NSString *) currencySymbol
{
    
    static NSNumberFormatter *_numberFormatter;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        
        _numberFormatter = [[NSNumberFormatter alloc] init];
        [_numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [_numberFormatter setLenient:YES];
        [_numberFormatter setGeneratesDecimalNumbers:NO];
        _numberFormatter.currencySymbol= currencySymbol;
        _numberFormatter.maximumFractionDigits = 1;
        
    });
    
    [_numberFormatter setPositiveFormat:@"¤#,##0.#K"];

    
    return _numberFormatter;
}

+(instancetype) numberFormatterWithPercentageSymbol
{
    
    static NSNumberFormatter *_numberFormatter;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _numberFormatter = [[self class] _numberFormatterWithPercantageFormatterBehaviour];;
        
    });
    _numberFormatter.percentSymbol = @"%";
    return _numberFormatter;

}


+(instancetype) numberFormatterWithCustomSymbol:(NSString *) symbol
{
    static NSNumberFormatter *_numberFormatter;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _numberFormatter = [[self class] _numberFormatterWithPercantageFormatterBehaviour];;
        
    });
    
     _numberFormatter.percentSymbol = symbol;
    
    return _numberFormatter;
}

+(instancetype) numberFormatterWithYearSymbol
{
    return [self numberFormatterWithCustomSymbol:@" YEARS"];
}

+ (instancetype) _numberFormatterWithPercantageFormatterBehaviour
{
    NSNumberFormatter *_numberFormatter;
    
    _numberFormatter = [[NSNumberFormatter alloc] init];
    [_numberFormatter setNumberStyle: NSNumberFormatterPercentStyle];
    _numberFormatter.maximumFractionDigits = 2;
    _numberFormatter.usesGroupingSeparator = NO;
    [_numberFormatter setGeneratesDecimalNumbers:NO];
    _numberFormatter.multiplier = @1;
    _numberFormatter.maximum = @10000;
   
    return _numberFormatter;
}

+ (instancetype) numberFormatterForUnsignedInteger
{
    static NSNumberFormatter *_numberFormatter;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    
    _numberFormatter = [[NSNumberFormatter alloc] init];
    [_numberFormatter setNumberStyle: NSNumberFormatterNoStyle];
    _numberFormatter.maximumFractionDigits = 0;
    [_numberFormatter setGeneratesDecimalNumbers:NO];
    _numberFormatter.multiplier = @1;
    _numberFormatter.maximum = @1000;
    
    });
    
    return _numberFormatter;
}

+(NSString *) valueFormattedByUnit:(NSNumber *) value
{
    if (fabs([value doubleValue]) >= 1000 && fabs([value doubleValue]) < 1000000) {
        value = [NSNumber numberWithDouble:[value doubleValue]/1000.0];
        return [[NSNumberFormatter numberFormatterForAmountLabelWithLocalCurrencySymbolWithMeasurmentUnitString:NSLocalizedString(@"K", @"thouthandsUnitSymbol")] stringFromNumber:value];
    }
    
    if (fabs([value doubleValue]) >= 1000000) {
        value = [NSNumber numberWithDouble:[value doubleValue]/1000000.0];
        return [[NSNumberFormatter numberFormatterForAmountLabelWithLocalCurrencySymbolWithMeasurmentUnitString:NSLocalizedString(@"M", @"millionsUnitSymbol")] stringFromNumber:value];
        
    }
    
    return [[NSNumberFormatter numberFormatterForCurrencyWithUserLocaleCurrencySymbol] stringFromNumber:value];
}

+(NSString *) currencySymbolForCurrentUserLocale
{
   return [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
}




@end
