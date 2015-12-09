//
//  FWTAuxiliaryRowDisplayDelegate.m
//  FWTCalculator
//
//  Created by Yevgeniy Prokoshev on 20/11/2015.
//  Copyright © 2015 Yevgeniy Prokoshev. All rights reserved.
//

#import "FWTAuxiliaryRowDisplayDelegate.h"
#import <UIKit/UIKit.h>
#import "FWTFormAppearanceManager.h"


@interface FWTAuxiliaryRowDisplayDelegate ()

@property (nonatomic) NSIndexPath *opendAuxiliaryRowIndexPath;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) FWTFormAppearanceManager *appearanceManager;

@end

@implementation FWTAuxiliaryRowDisplayDelegate

-(instancetype) initWithTableView:(UITableView *) tableView appearanceManager:(FWTFormAppearanceManager *) appearanceManager {
    
    NSAssert(tableView, @"Provide Table View");
    NSAssert(appearanceManager, @"Provide appearance Manager");

    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.appearanceManager = appearanceManager;
    }
    
    return self;
}


-(void) displayInlineAuxiliaryRowForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *visibleAuxilaryRowIndexPath = [self.appearanceManager visibleAuxilaryRowIndexPathInSection:indexPath.section];
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.tableView beginUpdates];
        
        BOOL before = NO;   // indicates if the AuxiliaryRow is below "indexPath", help us determine which row to reveal
        
      
        if (visibleAuxilaryRowIndexPath != nil)
        {
            before = visibleAuxilaryRowIndexPath.row < indexPath.row;
        }
        
        BOOL sameCellClicked = (visibleAuxilaryRowIndexPath.row - 1 == indexPath.row);
        
        if (visibleAuxilaryRowIndexPath)
        {
            FWTCellConfiguration *cellConfiguration  = [self.appearanceManager visibleCellConfigurationForIndexPath:visibleAuxilaryRowIndexPath];
            [self.appearanceManager removeRowsAtIndexPaths:@[cellConfiguration.indexPath]];
        }
        
        if (!sameCellClicked)
        {
            // hide the old date picker and display the new one
            NSInteger rowToReveal = (before ? indexPath.row - 1 : indexPath.row);
            NSIndexPath *indexPathToReveal = [NSIndexPath indexPathForRow:rowToReveal inSection:0];
            
            [self _toggleAuxiliaryRowWithAtIndexPath:indexPathToReveal];
            
        }
        [self.tableView endUpdates];
        
    } completion:^(BOOL finished) {
        if ([self _visibleAuxilaryRowIndexPathForSection:indexPath.section]!= nil) {
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }];
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

-(NSIndexPath *) _visibleAuxilaryRowIndexPathForSection:(NSUInteger) section
{
    return [self.appearanceManager visibleAuxilaryRowIndexPathInSection:section];
}

- (BOOL) _existAuxiliaryRowForIndexPath:(NSIndexPath *)indexPath
{
    FWTCellConfiguration *cellConfiguration =[self.appearanceManager visibleCellConfigurationForIndexPath:indexPath];
    
    return cellConfiguration.isAuxiliaryRow;
}


-(void) _toggleAuxiliaryRowWithAtIndexPath:(NSIndexPath *) indexPath
{
    
    FWTCellConfiguration *cellConfiguration  = [self.appearanceManager visibleCellConfigurationForIndexPath:indexPath];
    NSArray *auxiliaryRowTableViewIndexPaths = @[[NSIndexPath indexPathForRow:cellConfiguration.indexPath.row + 1 inSection:cellConfiguration.indexPath.section]];

    if ([self _existAuxiliaryRowForIndexPath:indexPath])
    {
        [self.appearanceManager removeRowsAtIndexPaths:auxiliaryRowTableViewIndexPaths];
    }
    else
    {
        [self.appearanceManager addRowsAtIndexPaths:auxiliaryRowTableViewIndexPaths];

    }
}


@end


