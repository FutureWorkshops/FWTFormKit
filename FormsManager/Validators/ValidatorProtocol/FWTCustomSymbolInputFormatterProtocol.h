//
//  FWTCustomFormatterSymbolStringValidatorProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 16/03/2015.
//
//

#import <Foundation/Foundation.h>

@protocol FWTCustomSymbolInputFormatterProtocol <NSObject>

@optional
-(BOOL) formatText:(NSString *) string withReplacedCharacter:(NSString *) string inRange:(NSRange) range;

@end
