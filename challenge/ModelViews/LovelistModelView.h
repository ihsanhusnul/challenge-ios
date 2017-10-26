//
//  LovelistModelView.h
//  challenge
//
//  Created by ihsan husnul on 10/26/17.
//  Copyright © 2017 IHsan HUsnul. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completionHandler) (NSDictionary *response, NSError *error);

@interface LovelistModelView : NSObject

+ (void)requestLovelistWithToken:(BOOL)shouldToken completionHandler:(completionHandler)completion;

@end
