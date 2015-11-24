//
//  FWTPercentValueInputValidator.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 10/03/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTStringValidatorProtocol.h"

@interface FWTCustomFormatterSymbolValueInputValidator : NSObject <FWTStringValidatorProtocol>


+(instancetype) percentInputValidatorWithFormatter:(NSNumberFormatter *) numberFormatter;


@end
