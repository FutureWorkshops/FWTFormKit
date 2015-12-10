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

-(instancetype) initWithValidationRules:(NSArray *) validationRules
{
    self = [super init];
    if (self) {
        self.validationRules = validationRules;
    }
    
    return self;
}


-(BOOL) isValidInputValue:(id) value {
    
    for (id <FWTValidationRule> validationRule in self.validationRules) {
        if (![validationRule evaluateWithValue:value]) return NO;
    }
    return YES;
}


@end
