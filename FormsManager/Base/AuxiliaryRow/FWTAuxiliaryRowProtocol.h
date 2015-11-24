//
//  FWTAuxiliaryRowProtocol.h
//  FWTCalculator
//
//  Created by Yevgeniy Prokoshev on 20/11/2015.
//  Copyright © 2015 Yevgeniy Prokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UITableView;

@protocol FWTAuxiliaryRowProtocol <NSObject>

-(void) displayInlineAuxiliaryRowForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
