//
//  FWTToolsMenuTableViewController.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 04/02/2015.
//
//

#import <UIKit/UIKit.h>
#import "FWTFormDescriptionProtocol.h"
#import "FWTFormsConstants.h"
#import "FWTCellObserverProtocol.h"
#import "FWTDynamicFormDatasourceProtocol.h"
#import "FWTFormAppearanceManager.h"
#import "FWTFormDescriptionKeyProtocol.h"
#import "FWTAuxiliaryRowProtocol.h"
#import "FWTObserverDelegate.h"
#import "FWTCellObserverManager.h"

@interface FWTFormsTableViewController : UITableViewController <FWTCellObservableProtocol, FWTDynamicFormDatasourceProtocol, FWTFormDescriptionKeyProtocol>


@property (nonatomic,readonly) FWTFormAppearanceManager *appearanceManager; //keep form appearance datasource and handle hide and show logic for form rows.
@property (nonatomic) NSDictionary *textFieldResponders; // all textField responders. Used when taped keyboard next button.
@property (nonatomic) id<FWTAuxiliaryRowProtocol> auxiliaryRowsHandler; // hanlde behaviour of auxiliaryRows attached to cells in the form.
@property (nonatomic) NSString *formDescriptionKey;

@property (nonatomic, weak) id <FWTObserverDelegate> observerDelegate; // cell KVO observer. Respond to KVO messages from Observable Cells.
@property (nonatomic) FWTCellObserverManager *observerManager;

-(instancetype)initWithFormDescriptionDataSource:(id<FWTFormDescriptionProtocol>)formDescriptionDataSource formDescriptionKey:(NSString *) formDesctiptionKey;
-(instancetype)initWithFormDescription:(id<FWTFormDescriptionProtocol>)formDescriptionDataSource;


-(void)setFormDescriptionDataSource:(id<FWTFormDescriptionProtocol>) formDescriptionDataSource;


// do not need to call super when ovveride this method
-(NSAttributedString *) attributedTextForHeaderInSection:(NSInteger) section;

// call super when ovverride this method;
-(id) nextViewControllerForSelectedCellAtIndexPath:(NSIndexPath *) indexPath;


@end

