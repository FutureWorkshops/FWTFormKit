//
//  FWTValidatorProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 12/03/2015.
//
//

#import <Foundation/Foundation.h>

@protocol FWTInputFormatterWithNumberFormatterProtocol <NSObject>

@required
-(NSNumberFormatter *) numberFormatter;


@end
