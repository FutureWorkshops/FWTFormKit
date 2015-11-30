//
//  FWTValueValidatorProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 10/03/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTInputFormatterWithNumberFormatterProtocol.h"

@protocol FWTValueFormatterProtocol <FWTInputFormatterWithNumberFormatterProtocol>

@required
-(BOOL) formatInputString:(NSString *) string withAppendum:(NSNumber *)value;
-(BOOL) formatInputString:(NSString *) string withDeduction:(NSNumber *)value;


@end
