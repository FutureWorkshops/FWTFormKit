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

@protocol FWTFormAppearanceManagerDelegate <NSObject>

@optional
-(void) formManagerWillRemoveRowWithConfiguration:(FWTCellConfiguration *) cellConfiguration;
-(void) formManagerWillAddRowWithConfiguration:(FWTCellConfiguration *) cellConfiguration;

@end

@interface FWTFormAppearanceManager : NSObject

@property (nonatomic,readonly) NSDictionary *formConfigurationDictionary;
@property (nonatomic, weak) id <FWTDynamicFormDatasourceProtocol> dynamicFormDataSource;
@property (nonatomic, weak) id <FWTFormAppearanceManagerDelegate> delegate;

-(instancetype) initWithFormConfigurationDictionary:(NSDictionary *) formConfigurationDictionary;
-(instancetype) initWithTableView:(UITableView *)tableView formConfigurationDictionary:(NSDictionary *)formConfigurationDictionary;


// configuration

-(void) addRowsAtIndexPaths:(NSArray *) indexPaths;
-(void) removeRowsAtIndexPaths:(NSArray *) indexPaths;


- (void) hide:(BOOL) hide formSection:(NSUInteger) section;
- (void) hide:(BOOL) hide formSections:(NSIndexSet *) sections;

-(void) setHidden:(BOOL) hidden formRowAtIndexPath:(NSIndexPath *)indexPath;
-(void) setHidden:(BOOL) hidden formRowsAtIndexPaths:(NSSet *)indexPathsSet;


// dataSource
- (FWTSectionConfiguration *) visibleSectionConfigurationWithIndex:(NSUInteger) sectionIndex;
- (FWTCellConfiguration *) visibleCellConfigurationForIndexPath:(NSIndexPath *) indexPath;
- (NSSet *) indexPathsForFormRowsInSection:(NSUInteger) section;
- (NSSet *) indexPathsForVisibleFormRowsInSection:(NSUInteger) section;


- (NSUInteger) numberOfVisibleSections;
- (NSUInteger) numberOfVisibleRowsInSection: (NSUInteger) section;
- (NSIndexPath *) visibleAuxilaryRowIndexPathInSection:(NSInteger) section;



@end

