
//
//  FWTFormAppearanceManager.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 22/05/2015.
//
//

#import "FWTFormAppearanceManager.h"
#import "FWTValidator.h"

@interface FWTFormAppearanceManager ()

@property (nonatomic) NSDictionary *formConfigurationDictionary;
@property (nonatomic) NSArray *formConfiguration;
@property (nonatomic) UITableView *tableView;


@end


@implementation FWTFormAppearanceManager

-(instancetype)initWithFormConfigurationDictionary:(NSDictionary *)formConfigurationDictionary
{
    self = [super init];
    if (self) {
        self.formConfigurationDictionary = formConfigurationDictionary;
        self.formConfiguration = [self _createFormConfigurationFromFormDescription:formConfigurationDictionary];
    }
    
    return self;
}

-(instancetype)initWithTableView:(UITableView *)tableView formConfigurationDictionary:(NSDictionary *)formConfigurationDictionary
{
    self = [self initWithFormConfigurationDictionary:formConfigurationDictionary];
    if (self) {
        self.tableView = tableView;
    }
    
    return self;
}
                  

#pragma mark - Public


-(void) hide:(BOOL)hide formRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide:hide formRowsAtIndexPaths:[NSSet setWithArray:@[indexPath]]];
}

-(void) hide:(BOOL)hide formRowsAtIndexPaths:(NSSet *)indexPathsSet
{
    for (NSIndexPath *indexPath in indexPathsSet) {
        FWTSectionConfiguration *section = [self visibleSectionConfigurationWithIndex:indexPath.section];
        [section hideCells:hide withIndexPaths:[NSSet setWithArray:@[indexPath]]];
    }
    
}

-(void) hide:(BOOL)hide formSection:(NSUInteger)section
{
    [self hide:hide formSections:[NSIndexSet indexSetWithIndex:section]];
}

-(void) hide:(BOOL)hide formSections:(NSIndexSet *) sections
{
     __weak typeof (self) weaKself = self;
     [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
         __strong typeof (weaKself) strongSelf = weaKself;
         FWTSectionConfiguration *sectionConfig = [strongSelf.formConfiguration objectAtIndex:idx];
         sectionConfig.hidden = hide;
     }];
      
}

// sections

- (NSUInteger) numberOfVisibleSections
{
    NSPredicate *notHiddenSection = [NSPredicate predicateWithFormat:@"(hidden != %@) AND (dynamicSectionKey = %@)", [NSNumber numberWithBool:YES], nil];
    NSArray *visibleSectionsArray = [self _sectionsConfigWithPredicate:notHiddenSection];
    NSUInteger numberOfVisibleAndDynamicSections = [visibleSectionsArray count];
    
    NSPredicate *dynamicSection = [NSPredicate predicateWithFormat:@"(hidden != %@) AND (dynamicSectionKey != %@)", [NSNumber numberWithBool:YES], nil];
    
    if ([self _formWithDynamicSections]) {
        for (FWTSectionConfiguration *section in [self _sectionsConfigWithPredicate:dynamicSection]) {
            if (section.dynamicSectionKey) {
                id <FWTDynamicFormDatasourceProtocol> dynamicSectionDataSource = self.dynamicFormDataSource;
                NSUInteger numberOfDynamicSections = [dynamicSectionDataSource numberOfDynamicSectionsWithKey:section.dynamicSectionKey];
                numberOfVisibleAndDynamicSections += numberOfDynamicSections;
                section.dynamicRange = NSMakeRange (section.index, numberOfDynamicSections);
            }
        }
    }
 
    return numberOfVisibleAndDynamicSections;
}

-(FWTSectionConfiguration *) visibleSectionConfigurationWithIndex:(NSUInteger)sectionIndex
{
    if ([self _formWithDynamicSections]) {
        for (FWTSectionConfiguration *section in self.formConfiguration) {
            if (section.dynamicSectionKey) {
                NSIndexSet *dynamicSectionIndexes = [NSIndexSet indexSetWithIndexesInRange:section.dynamicRange];
                if ([dynamicSectionIndexes containsIndex:sectionIndex]) {
                    sectionIndex = section.index;
                    NSPredicate *visibleDynamicSection = [NSPredicate predicateWithFormat:@"(hidden != %@)", [NSNumber numberWithBool:YES]];
                    return [[self _sectionsConfigWithPredicate:visibleDynamicSection] objectAtIndex:sectionIndex];

                }
            }
        }
    }
 
    NSAssert([self.formConfiguration count] > sectionIndex, @"Section Index exceed array bounds");
  
    NSPredicate *visibleSection = [NSPredicate predicateWithFormat:@"(hidden != %@) AND (dynamicSectionKey = %@)", [NSNumber numberWithBool:YES], nil];

    FWTSectionConfiguration *sectionConfig = [[self _sectionsConfigWithPredicate:visibleSection] objectAtIndex:sectionIndex];
    return sectionConfig;
}

// rows
-(NSUInteger) numberOfVisibleRowsInSection: (NSUInteger) sectionIndex
{
    FWTSectionConfiguration *sectionConfig = [self visibleSectionConfigurationWithIndex:sectionIndex];
    NSUInteger numberOfDynamicItems = 0;
    if (sectionConfig.sectionWithDynamicCells) {
        NSRange range = [self _dynamicCellsRangeForSectionWithIndex:sectionIndex];
        sectionConfig.dynamicCellsRangeForStaticSection = range;

        numberOfDynamicItems = range.length;
    }
    return [sectionConfig numberOfVisibleCellInSection] + numberOfDynamicItems;
}

-(FWTCellConfiguration *) visibleCellConfigurationForIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *visibleCellIndexPath = indexPath;
    
    FWTSectionConfiguration *sectionConfig = [self visibleSectionConfigurationWithIndex:indexPath.section];
    if (sectionConfig.sectionWithDynamicCells) {
        NSIndexSet *dynamicCellsIndexes;
        dynamicCellsIndexes =[NSIndexSet indexSetWithIndexesInRange:[self _dynamicCellsRangeForSectionWithIndex:indexPath.section]];
      
        if ([dynamicCellsIndexes containsIndex:indexPath.row]) {
            visibleCellIndexPath = [NSIndexPath indexPathForRow:[dynamicCellsIndexes firstIndex] inSection:indexPath.section];
        }
    }
    
    return [sectionConfig visibleCellConfigurationForIndexPath:visibleCellIndexPath];
}

#pragma mark - Private

-(NSRange) _dynamicCellsRangeForSectionWithIndex:(NSUInteger) sectionIndex
{
    FWTSectionConfiguration *sectionConfig = [self visibleSectionConfigurationWithIndex:sectionIndex];
    FWTCellConfiguration *cell = [sectionConfig dynamicCellConfiguration];
    id <FWTDynamicFormDatasourceProtocol> dynamicCellDataSource = self.dynamicFormDataSource;
    NSUInteger numberOfDynamicItems = [dynamicCellDataSource numberOfItemForDynamicRowsInSection:sectionIndex withKey:cell.dynamicCellKey];
   
    return NSMakeRange(cell.indexPath.row, numberOfDynamicItems);
}

-(BOOL) _formWithDynamicSections
{
    NSPredicate *dynamicSection = [NSPredicate predicateWithFormat:@"(hidden != %@) AND (dynamicSectionKey != %@)", [NSNumber numberWithBool:YES], nil];
   return [[self _sectionsConfigWithPredicate:dynamicSection] count] > 0;
}

-(NSArray *) _sectionsConfigWithPredicate:(NSPredicate *) predicate
{
    return [self.formConfiguration filteredArrayUsingPredicate:predicate];
}

-(NSArray *) _createFormConfigurationFromFormDescription:(NSDictionary *) formDescription
{
    NSMutableArray *formConfiguration = [NSMutableArray arrayWithCapacity:[formDescription[FWTGroupsConfigurationKey] count]];
    for (NSDictionary *sectionConfig in [formDescription[FWTGroupsConfigurationKey] allValues]) {
        NSUInteger sectionIndex =[[[formDescription[FWTGroupsConfigurationKey] allKeysForObject:sectionConfig] lastObject] integerValue];
       [formConfiguration addObject:[self _sectionConfigurationWithDescription:sectionConfig sectionIndex:sectionIndex]];
    }
    
    return formConfiguration;
}


-(FWTSectionConfiguration *) _sectionConfigurationWithDescription:(NSDictionary *) sectionDescription sectionIndex:(NSUInteger) sectionIndex
{
    NSMutableArray *cellsConfigurationArray = [[NSMutableArray alloc] initWithCapacity:[sectionDescription[FWTCellsConfigurationKey] count]];
    
    for (NSDictionary *cellConfig in sectionDescription[FWTCellsConfigurationKey]) {
        NSUInteger rowIndex = [sectionDescription[FWTCellsConfigurationKey] indexOfObject:cellConfig];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:rowIndex inSection:sectionIndex];
        [cellsConfigurationArray addObject:[self _cellConfigurationWithDescription:cellConfig indexPath:indexPath]];
    }
    
    FWTSectionConfiguration *section = [[FWTSectionConfiguration alloc] initWithCellsConfiguration:cellsConfigurationArray sectionIndex:sectionIndex];
    if (sectionDescription[FWTHeaderCellConfigurationKey] != [NSNull null]) {
        section.headerText = sectionDescription[FWTHeaderCellConfigurationKey][FWTItemTitle];
    }
    if (sectionDescription[FWTFooterCellConfigurationKey] != [NSNull null]) {
        section.footerText = sectionDescription[FWTFooterCellConfigurationKey][FWTItemTitle];
    }
    
    if (sectionDescription[FWTDynamicSectionDescriptionKey]) {
        section.dynamicSectionKey = sectionDescription[FWTDynamicSectionDescriptionKey];
    }
    
    return section;
}

-(FWTCellConfiguration *) _cellConfigurationWithDescription:(NSDictionary *) cellDescription indexPath:(NSIndexPath *) indexPath
{
    FWTCellConfiguration *cell = [[FWTCellConfiguration alloc] init];
    cell.indexPath = indexPath;
    cell.identifier = cellDescription[FWTItemCellIdentifier];
    cell.itemPropertyKey = cellDescription[FWTItemDataPropertyKey];
    cell.itemTitle = cellDescription[FWTItemTitle];
    cell.itemSubtitle = cellDescription[FWTItemSubTitle];
    if (cellDescription[FWTItemTitleIconImageName]) {
        cell.iconImage = [UIImage imageNamed:cellDescription[FWTItemTitleIconImageName]];
    }
    cell.nextViewControllerClass = cellDescription[FWTPresentViewControllerWithClassKey];
    cell.placeholderText = cellDescription[FWTItemPlaceholderText];
    cell.dynamicCellKey = cellDescription[FWTDynamicCellDescriptionKey];
    cell.hidden = [cellDescription[FWTCellIsHiddenKey] boolValue];
    cell.isAuxiliaryRowActivator = [cellDescription[FWTCellIsAuxiliaryRowActivator] boolValue];
    cell.isObservable = [cellDescription[FWTCellIsObservable] boolValue];
    if (cellDescription[FWTCellAccessoryViewImage]) {
        cell.accessoryViewImage = [UIImage imageNamed:cellDescription[FWTCellAccessoryViewImage]];
    }
    
    if (cellDescription[FWTCellInputFormatter]) {
        cell.inputFormatter = cellDescription[FWTCellInputFormatter];
    }
    
    if (cellDescription[FWTCellInputValidationRules]) {
        cell.validationRules = cellDescription[FWTCellInputValidationRules];
        NSNumberFormatter *cellNumberFormatter = [cell.inputFormatter numberFormatter];
        cell.inputValidator = [[FWTValidator alloc] initWithValidationRules:cell.validationRules numberFormatter:cellNumberFormatter];
    }
    
    return cell;
}


@end
