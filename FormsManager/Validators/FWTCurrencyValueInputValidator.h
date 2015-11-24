//
//  FWTCurrencyValueInputValidator.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 09/03/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTStringValidatorProtocol.h"
#import "FWTValueValidatorProtocol.h"

@interface FWTCurrencyValueInputValidator : NSObject <FWTStringValidatorProtocol, FWTValueValidatorProtocol>

@property (nonatomic) NSNumberFormatter *inputFormatter;

+(instancetype) currencyInputValidatorWithFormatter:(NSNumberFormatter *) numberFormatter;


-(long) longFromString:(NSString *) string;


@end
