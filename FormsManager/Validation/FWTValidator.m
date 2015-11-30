//
//  FWTValidator.m
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 30/11/2015.
//
//

#import "FWTValidator.h"
#import "FWTRangeValidationRule.h"
#import "FWTValidationRule.h"

@interface FWTValidator ()

@property (nonatomic) NSNumberFormatter *numberFormatter;
@property (nonatomic) NSArray *validationRules;

@end

@implementation FWTValidator

-(instancetype) initWithValidationRules:(NSArray *) validationRules numberFormatter:(NSNumberFormatter *) numberFormatter
{
    self = [super init];
    if (self) {
        self.validationRules = validationRules;
        self.numberFormatter = numberFormatter;
    }
    
    return self;
}


-(BOOL) isValidInputString:(NSString *) string {
    
    for (id <FWTValidationRule> validationRule in self.validationRules) {
        if (![validationRule evaluateWithObject:[self.numberFormatter numberFromString:string]]) return NO;
    }
    return YES;
}


@end
