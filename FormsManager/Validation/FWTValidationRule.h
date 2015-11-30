//
//  FWTValidationRule.h
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 30/11/2015.
//
//

#import <Foundation/Foundation.h>

@protocol FWTValidationRule <NSObject>

-(BOOL) evaluateWithObject:(id) object;

@end
