//
//  FWTPickerCell.m
//  FWTFormManager
//
//  Created by Marc Blasi on 20/02/2015.
//
//

#import "FWTPickerCell.h"
#import "UIFont+customFonts.h"

@interface FWTPickerCell () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) UIColor *titleColor;
@property (nonatomic) UIFont *titleFont;

@property (nonatomic) UIColor *complimentryBackGroundColor;

@end

@implementation FWTPickerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.pickerview.dataSource = self;
    self.pickerview.delegate = self;
    self.startDate = NSNotFound;
}

#pragma mark - Public
#pragma mark

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (self.selectedIndex != selectedIndex) {
        self->_selectedIndex = selectedIndex;
        [self.pickerview selectRow:selectedIndex inComponent:0 animated:YES];
    }
}

- (void)setOptionsValues:(NSArray *)optionsValues
{
    if (optionsValues != self.optionsValues) {
        self->_optionsValues = optionsValues;
        [self.pickerview reloadAllComponents];
    }
}

-(void)setTitleLabelColor:(UIColor *)color font:(UIFont *)font
{
    self.titleColor = color;
    self.titleFont = font;
}

-(void) setComplimentaryBackgroundColor:(UIColor *)complimentaryColor
{
    self.complimentryBackGroundColor = complimentaryColor;
}

#pragma mark - UIPickerViewDataSource

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.optionsValues count];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label =(UILabel *)view;
    
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.bounds.size.width, 43)];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = self.complimentryBackGroundColor ? self.complimentryBackGroundColor : self.contentView.backgroundColor;
        label.textColor = self.titleColor ? self.titleColor : [UIColor blackColor];
        label.font = self.titleFont ? self.titleFont : [UIFont systemFontOfSize:14.0f];
    }
    
    if (self.startDate != NSNotFound) {
        label.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.startDate + row];
    } else
    {
        label.text = [self.optionsValues objectAtIndex:row];
    }
    
    return label;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self willChangeValueForKey:@"selectedIndex"];
    _selectedIndex = row;
    [self didChangeValueForKey:@"selectedIndex"];
}

@end
