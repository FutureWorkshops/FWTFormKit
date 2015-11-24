//
//  FWTSectionConfiguration.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 22/05/2015.
//
//

#import "FWTSectionConfiguration.h"


@interface FWTSectionConfiguration ()


@end
@implementation FWTSectionConfiguration

-(instancetype)initWithCellsConfiguration:(NSArray *)cells sectionIndex:(NSUInteger)sectionIndex
{
    self = [super init];
    
    if (self) {
        self.index = sectionIndex;
        self.cellsConfiguration = cells;
        NSAssert(!(self.sectionWithDynamicCells && ([self _numberOfDynamicCells] > 1)), @"Unsuported Form Description configuration. Section should contain only single dynamic cell description. Description for section contains: %lu dynamic cells.To resolve - put them into different sections", (unsigned long)[self _numberOfDynamicCells]);
    }
    return self;
}
-(BOOL)isDynamicSection
{
    return [self.dynamicSectionKey length] > 0;
}

-(FWTCellConfiguration *) dynamicCellConfiguration
{
    NSPredicate *notHiddenCells = [NSPredicate predicateWithFormat:@"self.dynamicCellKey != %@", nil];
    return [[self.cellsConfiguration filteredArrayUsingPredicate:notHiddenCells] lastObject];
}

-(BOOL) sectionWithDynamicCells
{
    return [self _numberOfDynamicCells] > 0;
}

-(NSArray *)visibleCells
{
    NSPredicate *notHiddenCells = [NSPredicate predicateWithFormat:@"self.hidden != %@", [NSNumber numberWithBool:YES]];
    return [self.cellsConfiguration filteredArrayUsingPredicate:notHiddenCells];
}

-(void) hideCells:(BOOL) hide withIndexPaths:(NSSet *)indexPathSet
{
    for (NSIndexPath *indexPath in indexPathSet) {
        FWTCellConfiguration *cellConfiguration = [self.cellsConfiguration objectAtIndex:indexPath.row];
        if (cellConfiguration.dynamicCellKey != nil) {
            NSAssert(NO, @"Dynamic Cell Configuration Description Can't be hidden");
        }
        cellConfiguration.hidden = hide;
    }
}


- (void) hide:(BOOL) hide rowsWithIdentifier:(NSString *) rowIdentifier {
    NSPredicate *cellsWithIdentifier = [NSPredicate predicateWithFormat:@"(identifier == %@)", rowIdentifier];
    NSArray *cells = [self.cellsConfiguration filteredArrayUsingPredicate:cellsWithIdentifier];
    for (FWTCellConfiguration *cell in cells) {
        cell.hidden = hide;
    }
}



-(NSUInteger) numberOfCellsInForm
{
    return [self.cellsConfiguration count];
}

-(NSUInteger) numberOfVisibleCellInSection
{
    NSPredicate *notHiddenCells = [NSPredicate predicateWithFormat:@"(hidden != %@) AND (dynamicCellKey = %@)", [NSNumber numberWithBool:YES], nil];
    return [[self.cellsConfiguration filteredArrayUsingPredicate:notHiddenCells] count];
}

-(FWTCellConfiguration *) visibleCellConfigurationForIndexPath:(NSIndexPath *)indexPath
{

    if (NSLocationInRange(indexPath.row, self.dynamicCellsRangeForStaticSection)) {
        // dynamic cell
        return [self _dynamicCellConfigurationForRange:self.dynamicCellsRangeForStaticSection];   // return dynamicCell description for Section dynamic Cells range ( Section can countain only one dynamic cell description )
    }
    
    NSPredicate *visibleCellsPredicate = [NSPredicate predicateWithFormat:@"self.hidden != %@ AND (dynamicCellKey = %@)", [NSNumber numberWithBool:YES], nil];
    NSArray *visibleCells = [self.cellsConfiguration filteredArrayUsingPredicate:visibleCellsPredicate];
    
    NSIndexPath *visibleCellIndexPath = indexPath;
    
    // check for static cell description after Dynamic cell description
    if ((visibleCellIndexPath.row > [visibleCells count] - 1) && [self _numberOfDynamicCells] > 0) {
        visibleCellIndexPath = [NSIndexPath indexPathForRow:self.dynamicCellsRangeForStaticSection.location inSection:indexPath.section];
    }

   return [visibleCells objectAtIndex:visibleCellIndexPath.row];
}

-(FWTCellConfiguration *) cellConfigurationForIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellsConfiguration objectAtIndex:indexPath.row];
}


-(NSString *) description
{
    return [NSString stringWithFormat:@"Section Index = %lu, hidden = %u\nCells:%@, DynamicKey = %@", (unsigned long)self.index, self.hidden, self.cellsConfiguration, self.dynamicSectionKey];
}

#pragma mark - Private

-(FWTCellConfiguration *) _dynamicCellConfigurationForRange:(NSRange) range
{
    NSPredicate *dynamicCellPredicate = [NSPredicate predicateWithFormat:@"dynamicCellKey != %@", nil];
    NSArray *dynamicCells = [self.cellsConfiguration filteredArrayUsingPredicate:dynamicCellPredicate];
    
    return [dynamicCells lastObject];
}


-(NSUInteger) _numberOfDynamicCells
{
    NSPredicate *dynamicCells = [NSPredicate predicateWithFormat:@"self.dynamicCellKey != %@", nil];
    return [[self.cellsConfiguration filteredArrayUsingPredicate:dynamicCells] count];
}

@end
