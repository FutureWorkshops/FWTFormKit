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
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.tableView beginUpdates];
        
        BOOL before = NO;   // indicates if the AuxiliaryRow is below "indexPath", help us determine which row to reveal
        if ([self _hasInlineAuxiliaryRow])
        {
            before = self.opendAuxiliaryRowIndexPath.row < indexPath.row;
        }
        
        BOOL sameCellClicked = (self.opendAuxiliaryRowIndexPath.row - 1 == indexPath.row);
        
        if ([self _hasInlineAuxiliaryRow])
        {
            NSIndexPath *auxiliaryRowIndexPath = [NSIndexPath indexPathForRow:self.opendAuxiliaryRowIndexPath.row inSection:self.opendAuxiliaryRowIndexPath.section];
            FWTCellConfiguration *cellConfiguration  = [self.appearanceManager visibleCellConfigurationForIndexPath:auxiliaryRowIndexPath];
            [self.appearanceManager hide:YES formRowAtIndexPath:cellConfiguration.indexPath];
            [self.tableView deleteRowsAtIndexPaths:@[auxiliaryRowIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            self.opendAuxiliaryRowIndexPath = nil;
        }
        
        if (!sameCellClicked)
        {
            // hide the old date picker and display the new one
            NSInteger rowToReveal = (before ? indexPath.row - 1 : indexPath.row);
            NSIndexPath *indexPathToReveal = [NSIndexPath indexPathForRow:rowToReveal inSection:0];
            
            
            [self _toggleAuxiliaryRowWithAtIndexPath:indexPathToReveal];
            self.opendAuxiliaryRowIndexPath = [NSIndexPath indexPathForRow:indexPathToReveal.row + 1 inSection:0];
            
            
        }
        [self.tableView endUpdates];
        
    } completion:^(BOOL finished) {
        if (self.opendAuxiliaryRowIndexPath) {
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }];
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (BOOL) _existAuxiliaryRowForIndexPath:(NSIndexPath *)indexPath
{
    BOOL hasDatePicker = NO;
    
    NSInteger targetedRow = indexPath.row;
    targetedRow++;
    
    UITableViewCell *checkDatePickerCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:targetedRow inSection:0]];
    hasDatePicker = [checkDatePickerCell isKindOfClass:[FWTPickerRow class]];
    
    return hasDatePicker;
}

- (BOOL) _hasInlineAuxiliaryRow
{
    return (self.opendAuxiliaryRowIndexPath != nil);
}

-(void) _toggleAuxiliaryRowWithAtIndexPath:(NSIndexPath *) indexPath
{
    
    NSArray *auxiliaryRowTableViewIndexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section]];
    FWTCellConfiguration *cellConfiguration  = [self.appearanceManager visibleCellConfigurationForIndexPath:indexPath];
    NSArray *auxiliaryRowFormDescriptionIndexPaths =@[[NSIndexPath indexPathForRow:cellConfiguration.indexPath.row + 1 inSection:cellConfiguration.indexPath.section]];
    
    if ([self _existAuxiliaryRowForIndexPath:indexPath])
    {
        [self.appearanceManager hide:YES formRowsAtIndexPaths:[NSSet setWithArray:auxiliaryRowFormDescriptionIndexPaths]];
        [self.tableView deleteRowsAtIndexPaths:auxiliaryRowTableViewIndexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        [self.appearanceManager hide:NO formRowsAtIndexPaths:[NSSet setWithArray:auxiliaryRowFormDescriptionIndexPaths]];
        
        [self.tableView insertRowsAtIndexPaths:auxiliaryRowTableViewIndexPaths
                              withRowAnimation:UITableViewRowAnimationFade];

    }
}


@end


