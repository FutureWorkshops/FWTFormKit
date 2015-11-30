//
//  FWTPercentValueInputValidator.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 10/03/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTStringFormatterProtocol.h"

@interface FWTCustomSymbollnputFormatter : NSObject <FWTStringFormatterProtocol>

+(instancetype) inputFormatterWithCustomSymbol:(NSString *) customSymbol;
+(instancetype) percentInputFormatterWithNumberFormatter:(NSNumberFormatter *) numberFormatter;


@end
