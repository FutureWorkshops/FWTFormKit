//
//  FWTCellStringValidatorProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 09/03/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTValidatorWithFormatterProtocol.h"
#import "FWTPercentFormatterWithCustomSymbolValidatorProtocol.h"

@protocol FWTStringValidatorProtocol <FWTValidatorWithFormatterProtocol, FWTPercentFormatterWithCustomSymbolValidatorProtocol>

@optional
-(BOOL) validateText:(NSString *) string;

@required
-(NSString *) validatedString;


@end
