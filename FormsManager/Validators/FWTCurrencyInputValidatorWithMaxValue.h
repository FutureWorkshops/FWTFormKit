//
//  FWTCurrencyInputValidatorWithMaxValue.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 13/03/2015.
//
//

#import "FWTCurrencyValueInputValidator.h"
#import "FWTMaxValueValidatorProtocol.h"

@interface FWTCurrencyInputValidatorWithMaxValue : FWTCurrencyValueInputValidator <FWTMaxValueValidatorProtocol>

@property (nonatomic) NSNumber *maxValue;

+(instancetype) currencyInputValidatorWithFormatter:(NSNumberFormatter *) numberFormatter maxValue:(NSNumber *) maxValue;


@end
