//
//  FWTNameAndLableCell.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 09/02/2015.
//
//

#import "FWTNameAndLabelCell.h"

@implementation FWTNameAndLabelCell


-(void)updateConstraints
{
    [super updateConstraints];
    
    if (self.accessoryImageView.image == nil) {
        for (NSLayoutConstraint *constraint  in self.accessoryImageView.constraints) {
            if ([constraint.identifier isEqualToString:@"width"]) {
                constraint.constant = 0.0;
            }
        }
    }
}


-(void)setAccessoryViewImage:(UIImage *)image
{
    self.accessoryImageView.image = image;
}

-(void)setTitle:(NSString *)title
{
    self.itemTitleLable.text = title;
}

-(void)setTitleLabelColor:(UIColor *)color font:(UIFont *)font
{
    self.itemTitleLable.textColor = color;
    self.itemTitleLable.font = font;
}

-(void)setValueLabelColor:(UIColor *)color font:(UIFont *)font
{
    self.valueLabel.textColor = color;
    self.valueLabel.font = font;
}


@end
