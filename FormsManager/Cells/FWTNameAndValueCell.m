//
//  FWTNameAndValueCell.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 06/02/2015.
//
//

#import "FWTNameAndValueCell.h"
#import "UITextField+FWT.h"
#import "FWTStringValidatorProtocol.h"

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

#pragma mark - textfieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *replaced = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([self.validator conformsToProtocol:@protocol(FWTStringValidatorProtocol)]) {
        if ([self.validator respondsToSelector:@selector(validateText:)]) {
            if ([self.validator validateText:replaced]) {
                self.valueTextField.text = [self.validator validatedString];
            } else {
                [textField inputError];
            };

            return NO;
        } else if ([self.validator respondsToSelector:@selector(validateText:withReplacedCharacter:inRange:)])
        {
            if ([self.validator validateText:textField.text withReplacedCharacter:string inRange:range]) {
                self.valueTextField.text = [self.validator validatedString];
            } else
            {
                [textField inputError];
               
            }
             return NO;
        }
    }
    
    return YES;
}


#pragma mark - FWTTextFieldResponderProtocol


-(NSArray *)textFieldRespondersTags
{
    self.valueTextField.tag = 100;
    return @[[NSNumber numberWithInteger:self.valueTextField.tag]];
}



@end

