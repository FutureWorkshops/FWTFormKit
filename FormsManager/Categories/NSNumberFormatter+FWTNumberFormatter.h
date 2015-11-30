//
//  NSNumberFormatter+FWTNumberFormatter.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 15/01/2015.
//
//

#import <Foundation/Foundation.h>

@interface NSNumberFormatter (FWTNumberFormatter)

+ (instancetype) numberFormatterForCurrencyWithUserLocaleCurrencySymbol;
+ (instancetype) numberFormatterForAmountInputWithCurrencySymbol:(NSString *) currencySymbol;
+ (instancetype) numberFormatterWithDecimalFormattingAndCurrencySymbol:(NSString *) currencySymbol;
+ (instancetype) numberFormatterForAmountLabelWithLocalCurrencySymbolWithMeasurmentUnitString:(NSString *) measurmentUnitString;
+ (instancetype) numberFormatterWithPercentageSymbol;
+ (instancetype) numberFormatterWithYearSymbol;
+ (instancetype) numberFormatterWithCustomSymbol:(NSString *) symbol;

+ (instancetype) numberFormatterForUnsignedInteger;
+ (NSString *) currencySymbolForCurrentUserLocale;
+ (NSString *) valueFormattedByUnit:(NSNumber *) value;


@end
