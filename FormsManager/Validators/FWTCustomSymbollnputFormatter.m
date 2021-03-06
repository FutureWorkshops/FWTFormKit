//
//  FWTPercentValueInputValidator.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 10/03/2015.
//
//

#import "FWTCustomSymbollnputFormatter.h"
#import "NSNumberFormatter+FWTNumberFormatter.h"


@interface FWTCustomSymbollnputFormatter ()

@property (nonatomic) NSString *formattedString;
@property (nonatomic, copy) FWTCustomSymbolBlock customSymbolBlock;
@property (nonatomic) NSNumberFormatter *numberFormatter;

@end
@implementation FWTCustomSymbollnputFormatter


+(instancetype) inputFormatterWithCustomSymbol:(NSString *) customSymbol
{
    FWTCustomSymbollnputFormatter *inputFormatter  = [FWTCustomSymbollnputFormatter new];
    inputFormatter.numberFormatter = [NSNumberFormatter numberFormatterWithCustomSymbol:customSymbol];
    inputFormatter.numberFormatter.percentSymbol= customSymbol;
    return inputFormatter;
}


+(instancetype) inputFormatterWithCustomSymbolBlock:(FWTCustomSymbolBlock) block
{
    FWTCustomSymbollnputFormatter *inputFormatter  = [FWTCustomSymbollnputFormatter new];
    inputFormatter.numberFormatter = [NSNumberFormatter numberFormatterWithCustomSymbol:@""];
    inputFormatter.customSymbolBlock = block;
    if (block) {
        inputFormatter.numberFormatter.percentSymbol = block(nil);
    }
    return inputFormatter;
}


+(instancetype) percentInputFormatterWithNumberFormatter:(NSNumberFormatter *) numberFormatter;
{
    FWTCustomSymbollnputFormatter *inputFormatter  = [FWTCustomSymbollnputFormatter new];
    inputFormatter.numberFormatter = numberFormatter;
    return inputFormatter;
}


-(BOOL)formatText:(NSString *)string withReplacedCharacter:(NSString *) character inRange:(NSRange)range{
    
    NSRange meaningNumberRange;
    NSUInteger minimumTextLenght;
            
    meaningNumberRange  = range;
    NSInteger location = range.location - self.numberFormatter.percentSymbol.length;
    if (location < 0) {
        location = 0;
        string = self.numberFormatter.percentSymbol;
    }
    
    meaningNumberRange.location = location;
    minimumTextLenght = self.numberFormatter.percentSymbol.length;
    
    NSString *replaced = [string stringByReplacingCharactersInRange:meaningNumberRange withString:character];
    NSNumber *replacedAmount = [self.numberFormatter numberFromString:replaced];
    
    
    if (replacedAmount == nil) {
        //Probably non numeric character OR all meaningful digits were deleted.
        if (replaced.length < minimumTextLenght + 1) {
            self.formattedString  = nil; //[self.inputFormatter stringFromNumber:@0];

            return YES;
        }
        return NO;
    }
    if (self.customSymbolBlock !=nil) {
        self.numberFormatter.percentSymbol = self.customSymbolBlock(replacedAmount);
    }
    
    self.formattedString  = [self.numberFormatter stringFromNumber:replacedAmount];

    return YES;
}


-(NSString *) formattedString
{
    return _formattedString;
}


@end
