//
//  FWTFormTextRespondersHandler.m
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 11/01/2016.
//
//

#import "FWTFormNextTextRespondersHandler.h"

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


-(void)selectNextResponderForCell:(UITableViewCell *)cell
{
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    if (cellIndexPath) {
        for (int i=cellIndexPath.section; i < [self.tableView numberOfSections]; ++i) {
            for (int j = cellIndexPath.row; j < [self.tableView numberOfRowsInSection:i]; ++j) {
                
                
            }
        }
    }
}

@end
