//
//  FWTSectionConfiguration.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 22/05/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTCellConfiguration.h"
#import "FWTDynamicFormDatasourceProtocol.h"

@interface FWTSectionConfiguration : NSObject

@property (nonatomic) NSArray *cellsConfiguration;
@property (nonatomic) NSArray *visibleCells;

@property (nonatomic) NSString *headerText;
@property (nonatomic) NSString *footerText;


@property (nonatomic) NSUInteger index;
@property (nonatomic) BOOL hidden;


// dynamic
@property (nonatomic, weak) id <FWTDynamicFormDatasourceProtocol> dynamicFormDataSource;

@property (nonatomic,getter = isDynamicSection) BOOL dynamicSection;
@property (nonatomic) NSString *dynamicSectionKey;
@property (nonatomic) NSRange dynamicRange;

@property (nonatomic) BOOL sectionWithDynamicCells;
@property (nonatomic) NSRange dynamicCellsRangeForStaticSection;


-(instancetype) initWithCellsConfiguration:(NSArray *) cells sectionIndex:(NSUInteger) sectionIndex;

// appearence
-(void) hideCells:(BOOL) hide withIndexPaths:(NSSet *)indexPathSet;
-(void) hide:(BOOL) hide rowWithIdentifier:(NSString *) rowIdentifier;

// dataSource
-(FWTCellConfiguration *) visibleCellConfigurationForIndexPath:(NSIndexPath *) indexPath;
-(FWTCellConfiguration *) cellConfigurationForIndexPath:(NSIndexPath *)indexPath;

- (NSSet *) indexPathsForFormRows;
- (NSSet *) indexPathsForVisibleFormRows;

-(NSUInteger) numberOfVisibleCellInSection;
-(void) updateTableViewIndexPathesForVisibleCells; //update visible cell indexpathes. This index pathes are correlated to index pathes in the table view.

// dynamic
-(FWTCellConfiguration *) dynamicCellConfiguration;




@end
