//
//  FWTNameAndValueCell.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 06/02/2015.
//
//

#import "FWTNameAndValueCell.h"
#import "FWTStringFormatterProtocol.h"

@interface FWTNameAndValueCell () <UITextFieldDelegate>

@end

@implementation FWTNameAndValueCell

- (void)awakeFromNib {

    [super awakeFromNib];
    self.valueTextField.delegate = self;    
}

-(void)setSubtitle:(NSString *)subtitle
{
    self.subtitleLabel.text = subtitle;
}

-(void)setPlaceHolder:(NSString *)placeHolder
{
    self.valueTextField.placeholder = placeHolder;
}

-(void)setTitle:(NSString *)title
{
    self.titleLable.text = title;
}

-(void)setTitleLabelColor:(UIColor *)color font:(UIFont *)font
{
    self.titleLable.textColor = color;
    self.titleLable.font = font;
}

-(void)setSubtitleColor:(UIColor *) color font:(UIFont *)font
{
    self.subtitleLabel.textColor = color;
    self.subtitleLabel.font = font;
}

-(void)setTextFieldColor:(UIColor *)color font:(UIFont *)font
{
    self.valueTextField.font = font;
    self.valueTextField.textColor = color;
}

-(void)setCellInputFormatter:(id)formatter
{
    self.inputFormatter = formatter;
}

-(void) setCellInputValidator:(id)validator
{
    self.inputValidator = validator;
}

#pragma mark - textfieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *replaced = [textField.text stringByReplacingCharactersInRange:range withString:string];
    replaced =[replaced stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self.inputFormatter conformsToProtocol:@protocol(FWTStringFormatterProtocol)]) {
        if ([self.inputFormatter respondsToSelector:@selector(formatInputText:)]) {
            if ([self.inputFormatter formatInputText:replaced]) {
                self.valueTextField.text = [self.inputFormatter formattedString];
            }
            return NO;
        } else if ([self.inputFormatter respondsToSelector:@selector(formatText:withReplacedCharacter:inRange:)])
        {
            if ([self.inputFormatter formatText:textField.text withReplacedCharacter:string inRange:range]) {
                self.valueTextField.text = [self.inputFormatter formattedString];
            }
            return NO;
        }
    }
    if ([self.inputErrorDelegate conformsToProtocol:@protocol(FWTCellValidationErrorDelegate)]) {

        if ([self.inputErrorDelegate restricInputBaseOnValidationRuleForCell:self]) {
            if (![self _validateInput:replaced]) {
                return NO;
            } else
            {
                self.valueTextField.text = replaced;
                return NO;
            }
        }
    }
    self.valueTextField.text = replaced;
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![self _validateInput:textField.text]) {
        if ([self.inputErrorDelegate conformsToProtocol:@protocol(FWTCellValidationErrorDelegate)]) {
            [self.inputErrorDelegate validationStatus:FWTInputValidationStatusIsInvalid inCell:self];
        }
    } else {
        if ([self.inputErrorDelegate conformsToProtocol:@protocol(FWTCellValidationErrorDelegate)]) {
            [self.inputErrorDelegate validationStatus:FWTInputValidationStatusIsValid inCell:self];
        }
    }
    
}

#pragma mark - FWTTextFieldResponderProtocol


-(UITextField *) nextTextFieldResponder
{
    return self.valueTextField;
}

-(BOOL) _validateInput:(NSString *) string
{
    id value = nil;
    if ([self.inputValidator conformsToProtocol:@protocol(FWTValidationProtocol)]) {
        NSNumberFormatter *formatter = [self.inputFormatter numberFormatter];
        if (formatter) {
            value = [formatter numberFromString:string];
        } else {
            value = string;
        }
        
        return [self.inputValidator isValidInputValue:value];
    }
    return NO;
}

@end

