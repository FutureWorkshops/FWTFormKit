//
//  FWTCellContentMarginProtocol.h
//  FWTCalculator
//
//  Created by Yevgeniy Prokoshev on 21/11/2015.
//  Copyright © 2015 Yevgeniy Prokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FWTCellAppearanceProtocol <NSObject>

@optional
-(void) setContentMargin:(CGFloat) margin;
-(void) setCellBackgroundColor:(UIColor *) color;
-(void) setComplimentaryBackGroundColor:(UIColor *) complimentaryColor;
-(void) setTitleLableColor:(UIColor *) color font:(UIFont *) font;
-(void) setSubtitleColor:(UIColor *) colot font:(UIFont *) font;

@end
