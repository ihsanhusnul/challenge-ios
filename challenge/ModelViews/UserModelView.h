//
//  UserModelView.h
//  challenge
//
//  Created by ihsan husnul on 10/21/17.
//  Copyright © 2017 IHsan HUsnul. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completionHandler) (NSDictionary *response, NSError *error);

@interface UserModelView : NSObject

+ (void)requestLogin:(NSString*)username withPassword:(NSString*)password completionHandler:(completionHandler)completion;

+ (void)saveUserToken:(NSString*)token;
+ (NSString*)userToken;

@end
