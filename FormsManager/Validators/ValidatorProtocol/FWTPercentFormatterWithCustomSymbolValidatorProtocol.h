//
//  FWTCustomFormatterSymbolStringValidatorProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 16/03/2015.
//
//

#import <Foundation/Foundation.h>

@protocol FWTPercentFormatterWithCustomSymbolValidatorProtocol <NSObject>

@optional
-(BOOL) validateText:(NSString *) string withReplacedCharacter:(NSString *) string inRange:(NSRange) range;

@end
