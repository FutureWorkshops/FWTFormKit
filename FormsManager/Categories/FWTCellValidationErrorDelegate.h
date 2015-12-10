//
//  FWTTextFieldInputError.h
//  FWTTextFieldInputError
//
//  Created by Yevgeniy Prokoshev on 25/11/2015.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , FWTInputValidationStatus) {
    FWTInputValidationStatus_Not_Set = 0,
    FWTInputValidationStatusIsInvalid =1,
    FWTInputValidationStatusIsValid
};

@protocol FWTCellValidationErrorDelegate <NSObject>

-(UIColor *) textColorForErrorInCell:(UITableViewCell *) cell;
-(void) validationStatus:(FWTInputValidationStatus) inputValidationStatus inCell:(UITableViewCell *) cell;
-(BOOL) restricInputBaseOnValidationRuleForCell:(UITableViewCell *) cell;

@end
