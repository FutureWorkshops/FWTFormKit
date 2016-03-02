//
//  FWTCustomOutputFormatter.h
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 02/03/2016.
//
//

#import <Foundation/Foundation.h>
#import "FWTOutputFormatter.h"

typedef NSString * (^FWTCustomSymbolBlock) (NSNumber *value);

typedef NS_ENUM(NSUInteger, FWTOutputFormatterType)  {
    FWTOutputFormatterTypeLocalCurrencySymbol = 0,
    FWTOutputFormatterTypePercentageSymbol
    
};

@interface FWTCustomOutputFormatter : NSObject <FWTOutputFormatter>

+(instancetype) formatterWithCustomSymbol:(NSString *) customSymbol;
+(instancetype) formatterWithCustomSymbolBlock:(FWTCustomSymbolBlock) block;
+(instancetype) formatterWithType:(FWTOutputFormatterType) type;


-(NSString *) formattedStringFromNumber:(NSNumber *) number;


@end
