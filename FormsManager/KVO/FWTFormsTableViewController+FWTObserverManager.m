//
//  FWTFormsTableViewController+FWTObserverManager.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 20/05/2015.
//
//

#import "FWTFormsTableViewController+FWTObserverManager.h"
#import "FWTObserverDelegate.h"

@implementation FWTFormsTableViewController (FWTObserverManager)


#pragma mark - FWTKVOObserverProtocol

-(void) observer:(FWTKVO *)observer didRecieveValueChange:(NSDictionary *)change
{
    if ([self.observerDelegate conformsToProtocol:@protocol(FWTObserverDelegate)]) {
        [self.observerDelegate observeValueForKeyPath:observer.keyPath ofObject:observer.subject change:change];
    }
}


-(void) registerObserverForCell:(UITableViewCell *) cell withIndexPath:(NSIndexPath *) indexPath forKeyPath:(NSString *) keyPath
{
    NSMutableDictionary *observedCells = [self.observedCells mutableCopy];
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
