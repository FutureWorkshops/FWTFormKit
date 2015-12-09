//
//  FWTCellConfiguration.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 22/05/2015.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FWTInputFormatterWithNumberFormatterProtocol.h"
@interface FWTCellConfiguration : NSObject

@property (nonatomic) NSString *identifier;
@property (nonatomic) NSString *itemPropertyKey;
@property (nonatomic) NSString *itemTitle;
@property (nonatomic) NSString *itemSubtitle;
@property (nonatomic) UIImage  *iconImage;
@property (nonatomic, unsafe_unretained) Class nextViewControllerClass;
@property (nonatomic) NSString *dynamicCellKey;
@property (nonatomic) NSString *placeholderText;
@property (nonatomic) UIImage *accessoryViewImage;;
@property (nonatomic) BOOL isAuxiliaryRowActivator;
@property (nonatomic) BOOL isAuxiliaryRow;
@property (nonatomic) BOOL isObservable;
@property (nonatomic) id <FWTInputFormatterWithNumberFormatterProtocol> inputFormatter;
@property (nonatomic) id inputValidator;
@property (nonatomic) NSArray *validationRules;

@property (nonatomic) NSIndexPath * indexPath;
@property (nonatomic) BOOL hidden;
@property (nonatomic) NSIndexPath *visibleCellTableViewIndexPath;

@end
