//
//  LovelistModelView.m
//  challenge
//
//  Created by ihsan husnul on 10/26/17.
//  Copyright © 2017 IHsan HUsnul. All rights reserved.
//

#import "LovelistModelView.h"
#import "UserModelView.h"

@implementation LovelistModelView

+ (void)requestLovelistWithToken:(BOOL)shouldToken completionHandler:(completionHandler)completion {
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://dev.prelo.id/api/me/lovelist/1"]];
    
    [request setHTTPMethod:@"GET"];
    NSString *valueAuth = [NSString stringWithFormat:@"Token %@", [UserModelView userToken]];
    [request setValue:valueAuth forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"response %@", responseJson);
        
        completion(responseJson, error);
    }];
    [task resume];
}

@end
