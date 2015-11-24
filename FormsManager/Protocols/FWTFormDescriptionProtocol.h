//
//  FWTFormsDescription.h
//  FWTFormManager
//
//  Created by Marc Blasi on 25/02/2015.
//
//

#import <Foundation/Foundation.h>


@protocol FWTFormDescriptionProtocol <NSObject>

- (NSDictionary *) formDescriptionForKey:(NSString *) key;

@end
