//
//  FWTOutputFormatter.h
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 02/03/2016.
//
//

#import <Foundation/Foundation.h>

@protocol FWTOutputFormatter <NSObject>

-(NSString *) formattedStringFromNumber:(NSNumber *) number;


@end
