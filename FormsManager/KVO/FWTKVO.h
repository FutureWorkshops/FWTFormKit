//
//  FWTKVO.h
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 13/04/2015.
//
//

#import <Foundation/Foundation.h>
#import "FWTKVOProtocol.h"

@interface FWTKVO : NSObject
@property (nonatomic, weak, readonly) id subject;
@property (nonatomic, readonly) NSString *keyPath;
@property (nonatomic, weak, readonly) id <FWTKVOProtocol> observer;

- (void)stopObservation;

@end


@interface NSObject (FWTKVO)

- (FWTKVO *) observeKeyPath:(NSString *)keyPath
               withObsever:(id <FWTKVOProtocol>) observer;

- (FWTKVO *) observeSelector:(SEL) selector
                withObsever:(id<FWTKVOProtocol>)observer;

@end

