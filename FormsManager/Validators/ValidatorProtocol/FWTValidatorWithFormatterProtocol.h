//
//  FWTValidatorProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 12/03/2015.
//
//

#import <Foundation/Foundation.h>

@protocol FWTValidatorWithFormatterProtocol <NSObject>

@required
-(NSNumberFormatter *) inputFormatter;


@end
