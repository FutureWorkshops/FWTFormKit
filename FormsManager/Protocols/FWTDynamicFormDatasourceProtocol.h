//
//  FWTDynamicFormDescriptionProtocol.h
//  
//
//  Created by Yevgeniy Prokoshev on 23/03/2015.
//
//

#import <Foundation/Foundation.h>
@class FWTSectionConfiguration;

@protocol FWTDynamicFormDatasourceProtocol <NSObject>

- (NSString *) headerForDynamicSection:(FWTSectionConfiguration *) section withIndex:(NSUInteger) sectionIndex;
- (NSUInteger) numberOfItemForDynamicRowsInSection:(NSUInteger) section withKey:(NSString *) dynamicCellDescriptionKey;
- (NSUInteger) numberOfDynamicSectionsWithKey:(NSString *) dynamicSectionDescription;


@end
