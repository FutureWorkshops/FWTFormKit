//
//  FWTKVO.m
//  FWTFormManager
//
//  Created by Yevgeniy Prokoshev on 13/04/2015.
//
//

#import "FWTKVO.h"

static void* FWTKVOContext = &FWTKVOContext;
@implementation FWTKVO


- (id)initWithSubject:(id)subject
              keyPath:(NSString *)keyPath
                observer:(id <FWTKVOProtocol>) observer
{
    self = [super init];
    if (self) {
        _subject = subject;
        _keyPath = [keyPath copy];
        _observer = observer;
        [subject addObserver:self
                  forKeyPath:keyPath
                     options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                     context:FWTKVOContext];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (context == FWTKVOContext) {
        if (self.observer) {
            id observer = self.observer;
            [observer observer:self didRecieveValueChange:change];
        }
    }
}


- (void)stopObservation
{
    id subject = self.subject;
    [subject removeObserver:self
                      forKeyPath:self.keyPath
                         context:FWTKVOContext];
    _subject = nil;
}
- (void)dealloc
{
    [self stopObservation];
}


@end

@implementation NSObject (FWTKVO)

-(FWTKVO *)observeKeyPath:(NSString *)keyPath withObsever:(id<FWTKVOProtocol>)observer
{
    return [[FWTKVO alloc] initWithSubject:self keyPath:keyPath observer:observer];
}

-(FWTKVO *)observeSelector:(SEL)selector withObsever:(id<FWTKVOProtocol>)observer
{
    return [[FWTKVO alloc] initWithSubject:self keyPath:NSStringFromSelector(selector) observer:observer];
}

@end
