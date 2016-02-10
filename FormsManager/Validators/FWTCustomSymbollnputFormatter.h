//
//  FWTPercentValueInputValidator.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 10/03/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTStringFormatterProtocol.h"


typedef NSString * (^FWTCustomSymbolBlock) (NSNumber *value);

@interface FWTCustomSymbollnputFormatter : NSObject <FWTStringFormatterProtocol>

+(instancetype) inputFormatterWithCustomSymbol:(NSString *) customSymbol;
+(instancetype) inputFormatterWithCustomSymbolBlock:(FWTCustomSymbolBlock) block;
+(instancetype) percentInputFormatterWithNumberFormatter:(NSNumberFormatter *) numberFormatter;


@end
