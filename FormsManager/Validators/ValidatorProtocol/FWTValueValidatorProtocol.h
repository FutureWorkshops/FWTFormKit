//
//  FWTValueValidatorProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 10/03/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTValidatorWithFormatterProtocol.h"

@protocol FWTValueValidatorProtocol <FWTValidatorWithFormatterProtocol>

@required
-(BOOL) validateValueString:(NSString *) string withAppendum:(NSNumber *)value;
-(BOOL) validateValueString:(NSString *) string withDeduction:(NSNumber *)value;


@end
