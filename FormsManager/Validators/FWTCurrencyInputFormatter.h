//
//  FWTCurrencyValueInputValidator.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 09/03/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTStringFormatterProtocol.h"
#import "FWTValueFormatterProtocol.h"

@interface FWTCurrencyInputFormatter : NSObject <FWTStringFormatterProtocol, FWTValueFormatterProtocol>

@property (nonatomic) NSNumberFormatter *numberFormatter;

+(instancetype) currencyInputFormatterWithDefaultNumberFormatter;
+(instancetype) currencyInputFormatterWithNumberFormatter:(NSNumberFormatter *) numberFormatter;


-(long) longFromString:(NSString *) string;


@end
