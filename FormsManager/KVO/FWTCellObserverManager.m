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

@property (nonatomic,readwrite) NSDictionary *observedCells; 
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
    NSMutableDictionary *observedCells = self.observedCells ? [self.observedCells mutableCopy]: [NSMutableDictionary dictionaryWithCapacity:1];
    id observedCellKeyPaths = nil;
    
    FWTKVO *propertyObserver = [cell observeKeyPath:keyPath withObsever:self];
    
    if ([observedCells objectForKey:indexPath]) {
        if ([[observedCells objectForKey:indexPath] isKindOfClass:[NSArray class]]) {
            NSMutableArray *propertyObservers = [observedCells objectForKey:indexPath];
            [propertyObservers addObject:propertyObserver];
            observedCellKeyPaths = propertyObservers;
        } else
        {
            NSMutableArray *propertyObservers = [[NSMutableArray alloc] initWithCapacity:2];
            [propertyObservers addObject:[observedCells objectForKey:indexPath]];
            [propertyObservers addObject:propertyObserver];
            observedCellKeyPaths = propertyObservers;
        }
    } else
    {
        observedCellKeyPaths = propertyObserver;
    }
    
    [observedCells setObject:observedCellKeyPaths forKey:indexPath];
    
    self.observedCells = observedCells;
}


-(void) removeObserverForCellAtIndexPath:(NSIndexPath *) indexPath
{
    NSMutableDictionary *observedCells = [self.observedCells mutableCopy];
    
    if ([observedCells objectForKey:indexPath]) {
        if ([[observedCells objectForKey:indexPath] isKindOfClass:[NSArray class]]) {
            for (FWTKVO *propertyObserver in [observedCells objectForKey:indexPath]) {
                [propertyObserver stopObservation];
            }
        } else
        {
            FWTKVO *propertyObserver = [observedCells objectForKey:indexPath];
            [propertyObserver stopObservation];
        }
        
        [observedCells removeObjectForKey:indexPath];
    }
    
    self.observedCells = observedCells;
}

-(void) removeObserversForCells
{
    for (NSIndexPath *indexPath in [self.observedCells allKeys]) {
        [self removeObserverForCellAtIndexPath:indexPath];
    }
}


@end
