//
//  FWTFormCell.m
//  FWTCalculator
//
//  Created by Yevgeniy Prokoshev on 19/11/2015.
//  Copyright © 2015 Yevgeniy Prokoshev. All rights reserved.
//

#import "FWTFormCell.h"

@interface FWTFormCell ()

@property (nonatomic, readwrite) CGFloat contentMargin;
@property (strong, nonatomic) IBOutlet UIView *innerContentView;

@end

@implementation FWTFormCell


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    for (NSLayoutConstraint *constrain in self.contentView.constraints) {
        if (constrain.firstAttribute == NSLayoutAttributeTrailing || constrain.firstAttribute == NSLayoutAttributeLeading) {
            if (constrain.constant == self.contentMargin) return;
            constrain.constant = self.contentMargin;
        }
    }
}

-(void) setContentMargin:(CGFloat) margin
{
    if (self->_contentMargin != margin) {
        self->_contentMargin = margin;
        self.separatorInset = UIEdgeInsetsMake(0.0, margin, 0.0, margin);
    }
}

-(void)setCellBackgroundColor:(UIColor *)backgroundColor
{
    self.backgroundColor = backgroundColor;
    self.contentView.backgroundColor = backgroundColor;

}



@end
