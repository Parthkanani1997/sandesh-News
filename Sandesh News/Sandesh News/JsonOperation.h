//
//  JsonOperation.h
//  Sandesh News
//
//  Created by om technology on 08/01/1941 Saka.
//  Copyright © 1941 Panini Academy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonOperation : NSObject{
    BOOL jsonCome;
    NSInteger index;
}
-(void)getJsonFormAPI:(NSString*)urlString;
@property NSDictionary *dicJSon;
-(BOOL)isJsonCome;
@end
