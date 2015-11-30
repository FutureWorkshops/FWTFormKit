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

-(void)setTitleLableColor:(UIColor *)color font:(UIFont *)font
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
    if ([self.inputFormatter conformsToProtocol:@protocol(FWTStringFormatterProtocol)]) {
        if ([self.inputFormatter respondsToSelector:@selector(formatInputText:)]) {
            if ([self.inputFormatter formatInputText:replaced]) {
                self.valueTextField.text = [self.inputFormatter formattedString];
            } else {
                [self.inputErrorDelegate cell:self generateInputErrorInTextField:textField];
            };

            return NO;
        } else if ([self.inputFormatter respondsToSelector:@selector(formatText:withReplacedCharacter:inRange:)])
        {
            if ([self.inputFormatter formatText:textField.text withReplacedCharacter:string inRange:range]) {
                self.valueTextField.text = [self.inputFormatter formattedString];
            } else
            {
                [self.inputErrorDelegate cell:self generateInputErrorInTextField:textField];    
            }
             return NO;
        }
    }
    
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.inputValidator conformsToProtocol:@protocol(FWTValidationProtocol)]) {
        if (![self.inputValidator isValidInputString:textField.text]) {
            if ([self.inputErrorDelegate conformsToProtocol:@protocol(FWTTextFieldInputError)]) {
                [self.inputErrorDelegate cell:self generateInputErrorInTextField:textField];
            }
        }
    }
}

#pragma mark - FWTTextFieldResponderProtocol


-(NSArray *)textFieldRespondersTags
{
    self.valueTextField.tag = 100;
    return @[[NSNumber numberWithInteger:self.valueTextField.tag]];
}



@end

