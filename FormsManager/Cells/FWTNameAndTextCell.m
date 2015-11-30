//
//  FWTNameAndTextCell.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 11/02/2015.
//
//

#import "FWTNameAndTextCell.h"
#import "UITextField+FWT.h"

@interface FWTNameAndTextCell () <UITextFieldDelegate>

@end

@implementation FWTNameAndTextCell

- (void)awakeFromNib
{
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(handleTitleValueChanged:) forControlEvents:UIControlEventEditingChanged];
    
    // making 10 pixels margin from the left of the textField
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.textField.frame.size.height)];
    leftView.backgroundColor = [UIColor clearColor];
    self.textField.leftView = leftView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
}

-(void)setTextFieldColor:(UIColor *)color font:(UIFont *)font
{
    self.textField.font = font;
    self.textField.textColor = color;
}

#pragma mark - PlaceHolderProtocol 

-(void)setPlaceHolder:(NSString *)placeHolder
{
    self.textField.placeholder = placeHolder;
}

-(void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *replaced = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (replaced.length < 50) {
        return YES;
    }
    [self.inputErrorDelegate cell:self generateInputErrorInTextField:textField];
    
    return NO;
}

- (void)handleTitleValueChanged:(UITextField *)textField
{
    //KVO on UItextView is not supported as no effort has been made to make UIKit classes key-value observable http://stackoverflow.com/questions/6039309/when-does-an-associated-object-get-released/6051404#6051404
    self.textField.text = textField.text;
}


#pragma mark - FWTTextFieldResponderProtocol

-(NSArray *)textFieldRespondersTags
{
    self.textField.tag = 100;
    return @[[NSNumber numberWithInteger:self.textField.tag]];
}


@end
