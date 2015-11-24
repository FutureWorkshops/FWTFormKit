//
//  FWTObserverDelegate.h
//  FWTCalculator
//
//  Created by Yevgeniy Prokoshev on 23/11/2015.
//  Copyright © 2015 Yevgeniy Prokoshev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FWTObserverDelegate <NSObject>

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change;


@end
