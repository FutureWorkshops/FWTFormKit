//
//  FWTPercentValueInputValidator.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 10/03/2015.
//
//

#import "FWTCustomFormatterSymbolValueInputValidator.h"
#import "NSNumberFormatter+FWTNumberFormatter.h"


@interface FWTCustomFormatterSymbolValueInputValidator ()

@property (nonatomic) NSString *validatedString;
@property (nonatomic) NSNumberFormatter *inputFormatter;

@end
@implementation FWTCustomFormatterSymbolValueInputValidator


+(instancetype) percentInputValidatorWithFormatter:(NSNumberFormatter *) numberFormatter;
{
    FWTCustomFormatterSymbolValueInputValidator *validator  = [FWTCustomFormatterSymbolValueInputValidator new];
    validator.inputFormatter = numberFormatter;
    return validator;
}

-(NSNumberFormatter *) inputFormatter
{
    if (!_inputFormatter) {
        _inputFormatter = [NSNumberFormatter numberFormatterWithPercentageSymbol];
    }
    
    return _inputFormatter;
}

-(BOOL)validateText:(NSString *)string withReplacedCharacter:(NSString *) character inRange:(NSRange)range{
    
    NSRange meaningNumberRange;
    NSUInteger minimumTextLenght;
            
    meaningNumberRange  = range;
    NSInteger location = range.location - self.inputFormatter.percentSymbol.length;
    if (location < 0) {
        location = 0;
        string = self.inputFormatter.percentSymbol;
    }
    
    meaningNumberRange.location = location;
    minimumTextLenght = self.inputFormatter.percentSymbol.length;
    
    NSString *replaced = [string stringByReplacingCharactersInRange:meaningNumberRange withString:character];
    NSNumber *replacedAmount = [self.inputFormatter numberFromString:replaced];
    
    if (replacedAmount == nil) {
        //Probably non numeric character OR all meaningful digits were deleted.
        if (replaced.length < minimumTextLenght + 1) {
            self.validatedString  = [self.inputFormatter stringFromNumber:@0];
            return YES;
        }
        return NO;
    }
    
    self.validatedString  = [self.inputFormatter stringFromNumber:replacedAmount];

    return YES;
}


-(NSString *) validatedString
{
    return _validatedString;
}


@end
