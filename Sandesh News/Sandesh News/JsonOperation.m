//
//  JsonOperation.m
//  Sandesh News
//
//  Created by om technology on 08/01/1941 Saka.
//  Copyright © 1941 Panini Academy. All rights reserved.
//

#import "JsonOperation.h"
#import <UIKit/UIKit.h>
@implementation JsonOperation

-(id)init{
    index=1;
    jsonCome=NO;
    return self;
}
-(void)getJsonFormAPI:(NSString *)urlString{
  
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
           
                
                if (!error) {
                    // Success
                    if ([response isKindOfClass:[NSHTTPURLResponse class]])
                    {
                        NSError *jsonError;
                        self->_dicJSon= [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
                        if (jsonError) {
                            // Error Parsing JSON
                            
                        } else {
                            // Success Parsing JSON
                            // Log NSDictionary
                            self->jsonCome=YES;
                        }
                        
                        
                    }  else {
                        //Web server is returning an error
                    }
                } else {
                    // Fail
                    NSLog(@"error : %@", error.description);
                }
            }] resume];
}

-(BOOL)isJsonCome{
    if (jsonCome) {
        NSLog(@"Yes Now JSon is Came");
    }else{
        index++;
        NSLog(@"%d",index);
        [self isJsonCome];
    }
    return YES;
}
@end 
