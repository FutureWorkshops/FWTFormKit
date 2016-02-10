//
//  FWTFormTextRespondersHandler.m
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 11/01/2016.
//
//

#import "FWTFormNextTextRespondersHandler.h"
#import "FWTTextFieldResponderProtocol.h"


@interface FWTFormNextTextRespondersHandler ()

@property (nonatomic) UITableView *tableView;
@end

@implementation FWTFormNextTextRespondersHandler

-(instancetype)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        self.tableView = tableView;
    }
    return self;
}


-(void) selectNextResponderForCell:(UITableViewCell *)cell
{
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    if (cellIndexPath) {
        for (int i=cellIndexPath.section; i < [self.tableView numberOfSections]; ++i) {
            for (int j = cellIndexPath.row + 1; j < [self.tableView numberOfRowsInSection:i]; ++j) {
                UITableViewCell *nextFormCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
                if (nextFormCell) {
                    if ([nextFormCell conformsToProtocol:@protocol(FWTTextFieldResponderProtocol)]) {
                        UITableViewCell <FWTTextFieldResponderProtocol> *nextResponderCell = (UITableViewCell <FWTTextFieldResponderProtocol> *)nextFormCell;
                        UITextField *nextResponderTextField = [nextResponderCell nextTextFieldResponder];
                        if (nextResponderTextField) {
                            [nextResponderTextField becomeFirstResponder];
                            break;
                        }
                    }
                }
            }
        }
    }
    [cell endEditing:YES]; // of no next responder in the form- dismiss the keyboard.
}



@end
