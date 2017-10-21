//
//  UserModelView.m
//  challenge
//
//  Created by ihsan husnul on 10/21/17.
//  Copyright © 2017 IHsan HUsnul. All rights reserved.
//

#import "UserModelView.h"

@implementation UserModelView

#define UserLoggedInTokenKey @"UserLoggedInTokenKey"

+ (void)requestLogin:(NSString*)username withPassword:(NSString*)password completionHandler:(completionHandler)completion {
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://dev.prelo.id/api/auth/login"]];
    
    NSString *param = [NSString stringWithFormat:@"username_or_email=%@&password=%@", username, password];
    NSData *data = [param dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    [request setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"response %@", responseJson);
        
        if (responseJson) {
            [self saveUserToken:responseJson[@"_data"][@"token"]];
        }
        
        completion(responseJson, error);
    }];
    [task resume];
}

+ (void)saveUserToken:(NSString*)token {
    NSUserDefaults *cache = [NSUserDefaults standardUserDefaults];
    [cache setObject:token forKey:UserLoggedInTokenKey];
    [cache synchronize];
}

+ (NSString*)userToken {
    NSUserDefaults *cache = [NSUserDefaults standardUserDefaults];
    return [cache objectForKey:UserLoggedInTokenKey];
}
@end
