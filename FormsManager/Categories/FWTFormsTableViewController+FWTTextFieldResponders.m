//
//  FWTFormsTableViewController+FWTTextFieldResponders.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 28/04/2015.
//
//

#import "FWTFormsTableViewController+FWTTextFieldResponders.h"

@implementation FWTFormsTableViewController (FWTTextFieldResponders)


-(void) registerTextRespondersInCell:(UITableViewCell *) cell withIndexPath:(NSIndexPath *) indexPath
{
    id <FWTTextFieldResponderProtocol> textFieldCell = (id <FWTTextFieldResponderProtocol>) cell;
    if ([textFieldCell shoudRegisterAsTextResponder]) {
//        textFieldCell.textFieldResponderChainHandler = self;
        [self _registerNextResponder:[textFieldCell nextTextFieldResponder] forCell:cell];
    }
}

#pragma mark - FWTTextFieldResponderChainHandlerProtocol

-(void) nextResponderForCell:(UITableViewCell *)cell
{
//
//    id nextResponder  = [self.textFieldResponders ]
//    NSIndexPath *nextResponderIndexPath  = [[nextResponderDictionary allKeys] lastObject];
//    UITableViewCell *nextResponderCell = nil;
//    UITextField *nextResponderTextField=nil;
//    
//    nextResponderCell = [self.tableView cellForRowAtIndexPath:nextResponderIndexPath];
//    
//    if (nextResponderCell) {
//        if ([nextResponderCell conformsToProtocol:@protocol(FWTTextFieldResponderProtocol)]) {
//            [self.tableView scrollToRowAtIndexPath:nextResponderIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//            nextResponderTextField = (UITextField *)[nextResponderCell viewWithTag:[[nextResponderDictionary objectForKey:nextResponderIndexPath] integerValue]];
//            [nextResponderTextField becomeFirstResponder];
//        }
//    }
}

-(BOOL) haveNextResponderForCell:(UITableViewCell *)cell
{
//    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
//    NSDictionary *nextResponderDictionary = [self _indexForNextResponderAtIndexPath:cellIndexPath withTag:textViewTag];
//    return [[nextResponderDictionary allKeys] count] > 0;
    
    return YES;
}


-(void) removeTextResponderAtIndexPath:(NSIndexPath *) indexPath
{
    NSMutableDictionary *responders = [self.textFieldResponders mutableCopy];
    NSAssert([responders objectForKey:indexPath], @"No responders for indexPath %@", indexPath);
    
    if ([responders objectForKey:indexPath]) {
        [responders removeObjectForKey:indexPath];
    }
    
    self.textFieldResponders = responders;
}

-(void) removeAllTextResponders
{
    for (NSIndexPath *indexPath in [self.textFieldResponders allKeys]) {
        [self removeTextResponderAtIndexPath:indexPath];
    }
}

#pragma mark - Private

-(NSDictionary *) _indexForNextResponderAtIndexPath:(NSIndexPath *) indexPath withTag:(NSUInteger) textViewTag
{
    NSMutableDictionary *indexForNextResponder = [[NSMutableDictionary alloc] initWithCapacity:2];
    NSArray *sortedIndexPaths = [[self.textFieldResponders allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSIndexPath *registeredIndexPath in sortedIndexPaths) {
        if ([indexPath compare:registeredIndexPath] == NSOrderedAscending) {
            if ([[self.textFieldResponders objectForKey:indexPath] isKindOfClass:[NSArray class]]) {
                return [self _indexForNextResponderFromRespondersArray:[self.textFieldResponders objectForKey:indexPath] withIndexPath:registeredIndexPath viewTag:textViewTag];
            } else
            {
                [indexForNextResponder setObject:[self.textFieldResponders objectForKey:registeredIndexPath] forKey:registeredIndexPath];
                return indexForNextResponder;
            }
        } else if ([indexPath compare:registeredIndexPath] == NSOrderedSame) {
            if ([[self.textFieldResponders objectForKey:indexPath] isKindOfClass:[NSArray class]]) {
                return [self _indexForNextResponderFromRespondersArray:[self.textFieldResponders objectForKey:indexPath] withIndexPath:registeredIndexPath viewTag:textViewTag];
            }
        }
    }
    
    return indexForNextResponder;
}


-(NSDictionary *) _indexForNextResponderFromRespondersArray:(NSArray *) respondersArray withIndexPath:(NSIndexPath*) indexPath viewTag:(NSUInteger) textViewTag
{
    NSMutableDictionary *indexForNextResponder = [[NSMutableDictionary alloc] initWithCapacity:2];
    if ([respondersArray isKindOfClass:[NSArray class]]) {
        NSUInteger textViewTagIndex = [respondersArray indexOfObject:[NSNumber numberWithInteger:textViewTag]];
        if (textViewTagIndex < [respondersArray count] - 1) {
            [indexForNextResponder setObject:[respondersArray objectAtIndex:textViewTagIndex +1] forKey:indexPath];
            return indexForNextResponder;
        }
    }
    
    return indexForNextResponder;
}

-(void) _registerNextResponder:(id) responder forCell:(UITableViewCell *) cell
{
    NSMutableDictionary *responders = self.textFieldResponders ? [self.textFieldResponders mutableCopy] : [NSMutableDictionary dictionaryWithCapacity:1];
    
    [responders addEntriesFromDictionary:@{responder:cell}];
    
    self.textFieldResponders = responders;
}

@end
