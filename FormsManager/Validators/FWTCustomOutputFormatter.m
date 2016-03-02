//
//  FWTCustomOutputFormatter.m
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 02/03/2016.
//
//

#import "FWTCustomOutputFormatter.h"
#import "NSNumberFormatter+FWTNumberFormatter.h"


@interface FWTCustomOutputFormatter ()

@property (nonatomic) NSNumberFormatter *numberFormatter;
@property (nonatomic, copy) FWTCustomSymbolBlock customSymbolBlock;

@end

@implementation FWTCustomOutputFormatter


-(instancetype) initWithNumberFormatter:(NSNumberFormatter *) numberFormatter
{
    self = [super init];
    if (self) {
        self.numberFormatter = numberFormatter;

    }
    
    return self;
}

+(instancetype)formatterWithCustomSymbol:(NSString *)customSymbol
{
    NSNumberFormatter *numberFormatter = [NSNumberFormatter numberFormatterWithCustomSymbol:customSymbol];
    FWTCustomOutputFormatter *formatter = [[FWTCustomOutputFormatter alloc] initWithNumberFormatter:numberFormatter];
    return formatter;
}

+(instancetype)formatterWithCustomSymbolBlock:(FWTCustomSymbolBlock)block
{
    NSNumberFormatter *numberFormatter = [NSNumberFormatter numberFormatterWithCustomSymbol:@""];
    FWTCustomOutputFormatter *formatter = [[FWTCustomOutputFormatter alloc] initWithNumberFormatter:numberFormatter];
    formatter.customSymbolBlock = block;
    
    return formatter;

}


+(instancetype)formatterWithType:(FWTOutputFormatterType)type
{
    NSNumberFormatter *numberFormatter;
    
    switch (type) {
        case FWTOutputFormatterTypeLocalCurrencySymbol:
            numberFormatter = [NSNumberFormatter numberFormatterForCurrencyWithUserLocaleCurrencySymbol];
            break;
        case FWTOutputFormatterTypePercentageSymbol:
            numberFormatter = [NSNumberFormatter numberFormatterWithPercentageSymbol];
            break;
            
        default:
            break;
    }
    
    FWTCustomOutputFormatter *formatter = [[FWTCustomOutputFormatter alloc] initWithNumberFormatter:numberFormatter];
    
    return formatter;

}


-(NSString *) formattedStringFromNumber:(NSNumber *) number
{
    
    if (self.customSymbolBlock !=nil) {
        self.numberFormatter.percentSymbol = self.customSymbolBlock(number);
    }
    
    return [self.numberFormatter stringFromNumber:number];
}

@end
