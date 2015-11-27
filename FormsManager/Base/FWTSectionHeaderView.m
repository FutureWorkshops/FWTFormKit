//
//  FWTSectionHeaderView.m
//  FWTCalculator
//
//  Created by Yevgeniy Prokoshev on 19/11/2015.
//  Copyright © 2015 Yevgeniy Prokoshev. All rights reserved.
//


#define FWTHeaderMargin 20.0f
#import "FWTSectionHeaderView.h"


@implementation FWTSectionHeaderView

-(instancetype) initWithFrame:(CGRect) frame attributedString:(NSAttributedString *) attributedString {
    self = [super initWithFrame:frame];

    if (self) {
        CGRect newFrame = frame;
        CGFloat height = ([self _heightForViewWithString:attributedString] + FWTHeaderMargin);
        newFrame.size.height = MAX(54, height);
        self.frame = newFrame;
        [self addSubview:[self _labelWithAttributedString:attributedString]];
    }
    
    return self;
}

-(CGFloat) _heightForViewWithString:(NSAttributedString *) attributedString
{

    CGRect textFrame = [attributedString boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return textFrame.size.height;
}

-(UILabel *) _labelWithAttributedString:(NSAttributedString *) attributedString {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.attributedText = attributedString;
    [label sizeToFit];
    label.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    return label;
}

@end
