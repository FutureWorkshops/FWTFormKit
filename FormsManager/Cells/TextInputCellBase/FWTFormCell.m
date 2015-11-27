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

@end

@implementation FWTFormCell


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.bounds = CGRectMake(self.contentView.bounds.origin.x, self.contentView.bounds.origin.y, self.contentView.bounds.size.width - self.contentMargin * 2.0f, self.contentView.bounds.size.height);

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
