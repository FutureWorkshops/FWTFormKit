//
//  FWTCurrencyInputValidatorWithMaxValue.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 13/03/2015.
//
//

#import "FWTCurrencyInputFormatter.h"
#import "FWTMaxValueFormatterProtocol.h"

@interface FWTCurrencyInputFormatterWithMaxValue : FWTCurrencyInputFormatter <FWTMaxValueFormatterProtocol>

@property (nonatomic) NSNumber *maxValue;

+(instancetype) currencyInputFormatterWithNumberFormatter:(NSNumberFormatter *) numberFormatter maxValue:(NSNumber *) maxValue;


@end
