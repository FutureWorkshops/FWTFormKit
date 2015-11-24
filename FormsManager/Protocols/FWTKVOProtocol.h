//
//  FWTKVOProtocol.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 13/04/2015.
//
//

#import <Foundation/Foundation.h>

@class FWTKVO;

@protocol FWTKVOProtocol <NSObject>

- (void) observer:(FWTKVO *) observer didRecieveValueChange:(NSDictionary *) change;

@end
