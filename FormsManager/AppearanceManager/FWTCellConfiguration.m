//
//  FWTCellConfiguration.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 22/05/2015.
//
//

#import "FWTCellConfiguration.h"

@implementation FWTCellConfiguration


-(NSString *)description
{
    return [NSString stringWithFormat:@"Identifier : %@ , IndexPath:%@, tableViewIndexPath: %@ hidden = %u, DynamicKey=%@", self.identifier, self.indexPath, self.visibleCellTableViewIndexPath, self.hidden, self.dynamicCellKey];
}

@end
