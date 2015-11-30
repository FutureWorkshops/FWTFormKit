//
//  FWTToolsMenuTableViewController.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 04/02/2015.
//
//

#import "FWTFormsTableViewController.h"
#import "FWTFormsTableViewController+FWTTextFieldResponders.h"
#import "FWTTextFieldResponderProtocol.h"
#import "FWTFormsTableViewController+FWTObserverManager.h"
#import "FWTSectionHeaderView.h"
#import "FWTPickerCell.h"
#import "FWTAuxiliaryRowDisplayDelegate.h"
#import "FWTFormRows.h"
#import "FWTPlaceholder.h"
#import "FWTAccessoryView.h"
#import "FWTTitle.h"
#import "FWTSubtitle.h"
#import "FWTNameAndSwitchCell.h"

#define kDefaultHeightForHeaderView 60.0
#define kDefaultHeightForFooterView 60.0
#define kDefaultEstimatedCellHeight 80.0



@interface FWTFormsTableViewController ()

@property (nonatomic) id<FWTFormDescriptionProtocol> formDescriptionDataSource;
@property (nonatomic,readwrite) FWTFormAppearanceManager *appearanceManager;
@property (nonatomic) NSIndexPath *opendAuxiliaryRowIndexPath;

@end

@implementation FWTFormsTableViewController

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    
    return self;
}

-(instancetype)initWithFormDescriptionDataSource:(id<FWTFormDescriptionProtocol>)formDescriptionDataSource formDescriptionKey:(NSString *)formDesctiptionKey
{
    self = [self initWithFormDescription:formDescriptionDataSource];
    if (self) {
        self.formDescriptionKey = formDesctiptionKey;
    }
    
    return self;
}

- (instancetype)initWithFormDescription:(id<FWTFormDescriptionProtocol>)formDescriptionDataSource
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.formDescriptionDataSource = formDescriptionDataSource;
    }
    
     return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.showsHorizontalScrollIndicator = YES;
	self.tableView.backgroundColor = [UIColor whiteColor];
    self.clearsSelectionOnViewWillAppear = YES;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
}

-(void)dealloc
{
    [self removeObserversForCells];
}

-(id<FWTAuxiliaryRowProtocol>)auxiliaryRowsHandler
{
    if (!self->_auxiliaryRowsHandler) {
        self->_auxiliaryRowsHandler = [[FWTAuxiliaryRowDisplayDelegate alloc] initWithTableView:self.tableView appearanceManager:self.appearanceManager];
    }
    
    return self->_auxiliaryRowsHandler;
}

#pragma mark -Accessors

-(void)setFormDescriptionDataSource:(id<FWTFormDescriptionProtocol>) formDescriptionDataSource
{
    NSAssert(self.formDescriptionKey, @"formDescriptionKey must be set before setDescriptionDataSource");
    
    if (self->_formDescriptionDataSource != formDescriptionDataSource) {
        self->_formDescriptionDataSource = formDescriptionDataSource;
    
        if ([self conformsToProtocol:@protocol(FWTFormDescriptionKeyProtocol)]) {
            NSDictionary *cellsConfigurationDictionary = [self.formDescriptionDataSource formDescriptionForKey:self.formDescriptionKey];
            self.appearanceManager = [[FWTFormAppearanceManager alloc] initWithTableView:self.tableView formConfigurationDictionary:cellsConfigurationDictionary];
            self.appearanceManager.dynamicFormDataSource = self;
        }
    }
}

-(NSDictionary *)observedCells
{
    if (!_observedCells) {
        _observedCells = [[NSDictionary alloc] init];
    }
    
    return _observedCells;
}

-(NSDictionary *)textFieldResponders
{
    if (!_textFieldResponders) {
        _textFieldResponders = [[NSDictionary alloc] init];
    }
    return _textFieldResponders;
}


#pragma mark - Delegates
#pragma mark

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.appearanceManager numberOfVisibleSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.appearanceManager numberOfVisibleRowsInSection:section];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kDefaultEstimatedCellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self tableView:tableView viewForHeaderInSection:section].frame.size.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kDefaultHeightForFooterView;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSAttributedString *headerText = [self attributedTextForHeaderInSection:section];
    if (!headerText) {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    FWTSectionHeaderView *sectionHeader = [[FWTSectionHeaderView alloc] initWithFrame:self.tableView.frame attributedString:headerText];
    
    return sectionHeader;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wselector"

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FWTCellConfiguration *cellConfiguration = [self.appearanceManager visibleCellConfigurationForIndexPath:indexPath];
    
    NSString *cellIdentifier = cellConfiguration.identifier;
    UITableViewCell *cell = [self _tabelViewCellWithReuseIdentifier:cellIdentifier];
    if ([cell conformsToProtocol:@protocol(FWTPlaceholder)]) {
        [cell performSelector:@selector(setPlaceHolder:) withObject:cellConfiguration.placeholderText];
    }
    
    if ([cell conformsToProtocol:@protocol(FWTAccessoryView)]) {
        if (cellConfiguration.accessoryViewImage) {
            [cell performSelector:@selector(setAccessoryViewImage:) withObject:cellConfiguration.accessoryViewImage];
        }
    }
    
    if ([cell conformsToProtocol:@protocol(FWTTitle)]) {
        [cell performSelector:@selector(setTitle:) withObject:cellConfiguration.itemTitle];
    }
    
    if ([cell conformsToProtocol:@protocol(FWTSubtitle)]) {
        [cell performSelector:@selector(setSubtitle:) withObject:cellConfiguration.itemSubtitle];
    }
    
    
    return cell;
}
#pragma clang diagnostic pop



#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    

    // set custom separator insets for cell IOS8
    // http://stackoverflow.com/questions/25770119/ios-8-uitableview-separator-inset-0-not-working

    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    // registering observer for cell

    if ([self conformsToProtocol:@protocol(FWTCellObservableProtocol)]) {
        if ([self isObservableCell:cell forIndexPath:indexPath]) {
            for (NSString *keyPath in [self keyPathsForObservedCell:cell]) {
                [self registerObserverForCell:cell withIndexPath:indexPath forKeyPath:keyPath];
            }
        }
    }
    
    if ([cell conformsToProtocol:@protocol(FWTTextFieldResponderProtocol)]) {
        [self registerTextRespondersInCell:cell withIndexPath:indexPath];
        
    }
}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id nextViewController  = [self nextViewControllerForSelectedCellAtIndexPath:indexPath];
    if (nextViewController) {
        NSAssert(self.navigationController, @"Embed %@ into Navigation Controller if you want to use push navigation", self);
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
    
    FWTCellConfiguration *cellConfiguration  = [self.appearanceManager visibleCellConfigurationForIndexPath:indexPath];
    if (cellConfiguration.isAuxiliaryRowActivator) {
        [self.auxiliaryRowsHandler displayInlineAuxiliaryRowForRowAtIndexPath:indexPath];
    }
    
    return indexPath;
}



-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.observedCells objectForKey:indexPath]) {
        [self removeObserverForCellAtIndexPath:indexPath];
    }
}


#pragma mark - Public
#pragma mark

-(id) nextViewControllerForSelectedCellAtIndexPath:(NSIndexPath *) indexPath
{
    FWTCellConfiguration *cellConfiguration = [self.appearanceManager visibleCellConfigurationForIndexPath:indexPath];
    id nextViewController = nil;
    if ([cellConfiguration.nextViewControllerClass isSubclassOfClass:[self class]]) {
        nextViewController = [[cellConfiguration.nextViewControllerClass alloc] initWithFormDescription:self.formDescriptionDataSource];
    }
    
    return nextViewController;
}


-(NSAttributedString *) attributedTextForHeaderInSection:(NSInteger) section
{
    // this is calls when table view ask datasource for headerText for static Section;

    FWTSectionConfiguration *sectionConfiguration= [self.appearanceManager visibleSectionConfigurationWithIndex:section];
    
    if (sectionConfiguration.isDynamicSection) {
        return [[NSAttributedString alloc] initWithString:[self headerForDynamicSection:sectionConfiguration withIndex:section]];
    }
    
    if (sectionConfiguration.headerText) {
        return [[NSAttributedString alloc] initWithString:sectionConfiguration.headerText];
    }
    
    return nil;
}


#pragma mark - FWTDynamicFormDescriptionProtocol

-(NSUInteger)numberOfItemForDynamicRowsInSection:(NSUInteger)section withKey:(NSString *) dynamicCellDescriptionKey
{
    // this is calls when table view ask datasource for number of rowsInSection;
    NSAssert(NO, @"This is an abstract method and should be overridden in subclasses");
    return 0;
}

-(NSUInteger)numberOfDynamicSectionsWithKey:(NSString *)dynamicSectionDescription
{
    // this is calls when table view ask datasource for number of sections;
    NSAssert(NO, @"This is an abstract method and should be overridden in subclasses");
    return 0;
}

-(NSString *) headerForDynamicSection:(FWTSectionConfiguration *)section withIndex:(NSUInteger)sectionIndex
{
    // this is calls when table view ask datasource for header of sections;
    NSAssert(NO, @"This is an abstract method and should be overridden in subclasses");
    return 0;
}



#pragma mark - Private
#pragma mark


-(UITableViewCell *) _tabelViewCellWithReuseIdentifier:(NSString *) reuseIdentifier
{
    if (reuseIdentifier) {
        UITableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:reuseIdentifier owner:self options:nil] firstObject];
        NSAssert(cell, @"Cell with identifier - %@ does not exist", reuseIdentifier);
        return cell;
    }
    return nil;
}


#pragma mark - CellObserverProtocol

-(NSArray *) keyPathsForObservedCell:(UITableViewCell *)cell
{
    if ([cell isKindOfClass:[FWTNameAndValueCell class]]) {
        return @[@"valueTextField.text"];
    }
    
    if ([cell isKindOfClass:[FWTPickerCell class]]) {
        return @[@"selectedIndex"];
    }
    
    if ([cell isKindOfClass:[FWTNameAndTextCell class]])
    {
        return @[@"textField.text"];
    }
    
    if ([cell isKindOfClass:[FWTNameAndSwitchCell class]])
    {
        return @[@"switchSelectorState"];
    }
    
    return nil;
}

-(BOOL)isObservableCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *) indexPath
{
    return [self.appearanceManager visibleCellConfigurationForIndexPath:indexPath].isObservable;
}



@end
