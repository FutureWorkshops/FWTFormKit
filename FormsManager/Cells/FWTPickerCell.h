//
//  FWTPickerCell.h
//  FWTFormManager
//
//  Created by Marc Blasi on 20/02/2015.
//
//

#import <UIKit/UIKit.h>
#import "FWTFormCell.h"
#import "FWTCellAppearanceProtocol.h"

@interface FWTPickerCell : FWTFormCell

@property (nonatomic) IBOutlet UIPickerView *pickerview;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) NSArray *optionsValues;
@property (nonatomic) NSUInteger startDate;

@end
