//
//  FWTCellStringValidatorProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 09/03/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTInputFormatterWithNumberFormatterProtocol.h"
#import "FWTCustomSymbolInputFormatterProtocol.h"

@protocol FWTStringFormatterProtocol <FWTInputFormatterWithNumberFormatterProtocol, FWTCustomSymbolInputFormatterProtocol>

@optional
-(BOOL) formatInputText:(NSString *) string;

@required
-(NSString *) formattedString;


@end
