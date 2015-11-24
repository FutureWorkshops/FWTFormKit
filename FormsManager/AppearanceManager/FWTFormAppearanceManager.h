//
//  FWTFormAppearanceManager.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 22/05/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTFormsConstants.h"
#import "FWTSectionConfiguration.h"
#import "FWTCellConfiguration.h"
#import "FWTDynamicFormDatasourceProtocol.h"


@interface FWTFormAppearanceManager : NSObject

@property (nonatomic,readonly) NSDictionary *formConfigurationDictionary;
@property (nonatomic, weak) id <FWTDynamicFormDatasourceProtocol> dynamicFormDataSource;

-(instancetype) initWithFormConfigurationDictionary:(NSDictionary *) formConfigurationDictionary;
-(instancetype) initWithTableView:(UITableView *)tableView formConfigurationDictionary:(NSDictionary *)formConfigurationDictionary;


// configuration
- (void) hide:(BOOL) hide formSection:(NSUInteger) section;
- (void) hide:(BOOL) hide formSections:(NSIndexSet *) sections;

- (void) hide:(BOOL) hide formRowAtIndexPath:(NSIndexPath *) indexPath;
- (void) hide:(BOOL) hide formRowsAtIndexPaths:(NSSet *) indexPathsSet;


// dataSource
- (FWTSectionConfiguration *) visibleSectionConfigurationWithIndex:(NSUInteger) sectionIndex;
- (FWTCellConfiguration *) visibleCellConfigurationForIndexPath:(NSIndexPath *) indexPath;

- (NSUInteger) numberOfVisibleSections;
- (NSUInteger) numberOfVisibleRowsInSection: (NSUInteger) section;



@end

