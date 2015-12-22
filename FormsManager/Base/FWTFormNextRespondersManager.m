//
//  FWTFormNextRespondersManager.m
//  RBSProductPricing
//
//  Created by Yevgeniy Prokoshev on 21/12/2015.
//
//

#import "FWTFormNextRespondersManager.h"

@interface FWTFormNextRespondersManager ()

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *textFieldResponders;

@end


@implementation FWTFormNextRespondersManager


-(instancetype)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        self.tableView = tableView;
    }
        
    return self;
}

-(void) registerNextRespondersInCell:(UITableViewCell *) cell
{
    id <FWTTextFieldResponderProtocol> textFieldCell = (id <FWTTextFieldResponderProtocol>) cell;
    if ([self.textFieldResponders containsObject:cell]) return;
    
    if ([textFieldCell shoudRegisterAsTextResponder]) {
        NSMutableArray *responders = self.textFieldResponders ? [self.textFieldResponders mutableCopy] : [NSMutableArray arrayWithCapacity:1];
        NSIndexPath *cellIndexPath = [self.tableView indexPathForRowAtPoint:cell.center];
        if (cellIndexPath.row > [self.textFieldResponders count]) {
            [responders addObject:cell];
        } else
        {
            [responders insertObject:cell atIndex:cellIndexPath.row];
        }
//        NSLog(@"Add :%@", cell);

        textFieldCell.textFieldResponderChainHandler = self;
        self.textFieldResponders = responders;
    }
}

#pragma mark - FWTTextFieldResponderChainHandlerProtocol

-(void) nextResponderForCell:(UITableViewCell *)cell
{
//    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    
//
//    NSDictionary *nextResponderDictionary = [self _indexForNextResponderAtIndexPath:cellIndexPath withTag:textViewTag];
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
     NSIndexPath *cellIndexPath = [self.tableView indexPathForRowAtPoint:cell.center];
    
//    NSDictionary *nextResponderDictionary = [self _indexForNextResponderAtIndexPath:cellIndexPath withTag:textViewTag];
//    return [[nextResponderDictionary allKeys] count] > 0;
    
    return YES;
}


-(void) removeNextResponderForCell:(UITableViewCell *)cell
{
    NSMutableArray *responders = self.textFieldResponders ? [self.textFieldResponders mutableCopy] : [NSMutableArray arrayWithCapacity:1];
    if ([responders containsObject:cell]) {
        [responders removeObject:cell];
        
//        NSLog(@"Remove :%@", cell);
    }

    
    self.textFieldResponders = responders;
}

-(void) removeAllResponders
{
    self.textFieldResponders = nil;
}

#pragma mark - Private

//-(NSDictionary *) _indexForNextResponderAtIndexPath:(NSIndexPath *) indexPath withTag:(NSUInteger) textViewTag
//{
//    NSMutableDictionary *indexForNextResponder = [[NSMutableDictionary alloc] initWithCapacity:2];
//    NSArray *sortedIndexPaths = [[self.textFieldResponders allKeys] sortedArrayUsingSelector:@selector(compare:)];
//    for (NSIndexPath *registeredIndexPath in sortedIndexPaths) {
//        if ([indexPath compare:registeredIndexPath] == NSOrderedAscending) {
//            if ([[self.textFieldResponders objectForKey:indexPath] isKindOfClass:[NSArray class]]) {
//                return [self _indexForNextResponderFromRespondersArray:[self.textFieldResponders objectForKey:indexPath] withIndexPath:registeredIndexPath viewTag:textViewTag];
//            } else
//            {
//                [indexForNextResponder setObject:[self.textFieldResponders objectForKey:registeredIndexPath] forKey:registeredIndexPath];
//                return indexForNextResponder;
//            }
//        } else if ([indexPath compare:registeredIndexPath] == NSOrderedSame) {
//            if ([[self.textFieldResponders objectForKey:indexPath] isKindOfClass:[NSArray class]]) {
//                return [self _indexForNextResponderFromRespondersArray:[self.textFieldResponders objectForKey:indexPath] withIndexPath:registeredIndexPath viewTag:textViewTag];
//            }
//        }
//    }
//    
//    return indexForNextResponder;
//}
//
//
//-(NSDictionary *) _indexForNextResponderFromRespondersArray:(NSArray *) respondersArray withIndexPath:(NSIndexPath*) indexPath viewTag:(NSUInteger) textViewTag
//{
//    NSMutableDictionary *indexForNextResponder = [[NSMutableDictionary alloc] initWithCapacity:2];
//    if ([respondersArray isKindOfClass:[NSArray class]]) {
//        NSUInteger textViewTagIndex = [respondersArray indexOfObject:[NSNumber numberWithInteger:textViewTag]];
//        if (textViewTagIndex < [respondersArray count] - 1) {
//            [indexForNextResponder setObject:[respondersArray objectAtIndex:textViewTagIndex +1] forKey:indexPath];
//            return indexForNextResponder;
//        }
//    }
//    
//    return indexForNextResponder;
//}




@end
