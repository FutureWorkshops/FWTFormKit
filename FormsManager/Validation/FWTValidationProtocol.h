//
//  FWTValidationProtocol.h
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 30/11/2015.
//
//

#import <Foundation/Foundation.h>

@protocol FWTValidationProtocol <NSObject>

-(BOOL) isValidInputString:(NSString *) string;


@end
