//
//  FWTCellObserverProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 12/03/2015.
//
//

#import <Foundation/Foundation.h>

@protocol FWTCellObservableProtocol <NSObject>


@required
-(NSArray *) keyPathsForObservedCell:(UITableViewCell* ) cell;
-(BOOL) isObservableCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *) indexPath;


@end
