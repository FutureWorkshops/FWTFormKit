//
//  FWTCellObserverManager.m
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 30/11/2015.
//
//

#import "FWTCellObserverManager.h"
#import "FWTObserverDelegate.h"


@interface FWTCellObserverManager () <FWTKVOProtocol>

@property (nonatomic,readwrite) NSArray *observedCells;
@property (nonatomic,weak) id <FWTObserverDelegate> observerDelegate;

@end

@implementation FWTCellObserverManager

-(instancetype)initWithObserverDelegate:(id<FWTObserverDelegate>)delegate

{
    self = [super init];
    if (self) {
        self.observerDelegate = delegate;
    }
    
    return self;
}


-(void) observer:(FWTKVO *)observer didRecieveValueChange:(NSDictionary *)change
{
    id observerDelegate = self.observerDelegate;
    
    if ([observerDelegate conformsToProtocol:@protocol(FWTObserverDelegate)]) {
        [observerDelegate observeValueForKeyPath:observer.keyPath ofObject:observer.subject change:change];
    }
}


-(void) registerObserverForCell:(UITableViewCell *) cell withIndexPath:(NSIndexPath *) indexPath forKeyPath:(NSString *) keyPath
{
    NSMutableArray *observedCells = self.observedCells ? [self.observedCells mutableCopy]: [NSMutableArray arrayWithCapacity:1];
    
    FWTKVO *propertyObserver = [cell observeKeyPath:keyPath withObsever:self];
    
    [observedCells addObject:propertyObserver];
    self.observedCells = observedCells;
}


-(void) removeObserverForCell:(UITableViewCell *) cell atIndexPath:(NSIndexPath *) indexPath
{
    NSMutableArray *observedCells = [self.observedCells mutableCopy];
    
    for (FWTKVO *observer in self.observedCells) {
        if (observer.subject == cell) {
            [observer stopObservation];
            [observedCells removeObject:observer];
        }
    }
    
    self.observedCells = observedCells;
}

-(void) removeObserversForCells
{
    for (FWTKVO *observer in self.observedCells) {
        [observer stopObservation];
    };
    self.observedCells = nil;
}


@end
