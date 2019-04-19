//
//  DatePageViewController.m
//  Sandesh News
//
//  Created by om technology on 07/01/1941 Saka.
//  Copyright © 1941 Panini Academy. All rights reserved.
//

#import "DatePageViewController.h"
#import "ReadPaperViewController.h"
#import "JsonOperation.h"

@interface DatePageViewController ()

@end

@implementation DatePageViewController
@synthesize getCatId;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lblEditionName.text=_getEditionName;
   _datePIcker.datePickerMode=UIDatePickerModeDate;
      //string convert to date
    dateFormater=[[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"%@",[dateFormater stringFromDate:[NSDate date]]);
    _datePIcker.maximumDate=[NSDate date];
    
     NSString *myString = @"2019-03-25";
   
    _datePIcker.minimumDate = [dateFormater dateFromString:myString];
  
    dicEditionId=[[NSMutableDictionary alloc]init];
    _spinner.hidden=YES;
    _spinner.color=UIColor.blackColor;
   // NSString *urlAsString = [NSString stringWithFormat:@"http://epaper.sandesh.com/main/editionsbycategory?cat_id=37&ed_date=2019-03-28"];
    
  
   
   
}



- (IBAction)btnGo:(id)sender {
//
    [self.spinner startAnimating];
    self->_spinner.hidden=NO;

    JsonOperation *object =[[JsonOperation alloc]init];
     NSString *urlString;
    urlString = [NSString stringWithFormat:@"http://epaper.sandesh.com/main/editionsbycategory?cat_id=%@&ed_date=%@",getCatId,[dateFormater stringFromDate:_datePIcker.date]];
    [object getJsonFormAPI:urlString];
    [object isJsonCome];
     NSLog(@"%@",urlString);
    
    NSLog(@"date:%@",[dateFormater stringFromDate:_datePIcker.date]);
    NSString *rlString;
    urlString = [NSString stringWithFormat:@"http://epaper.sandesh.com/main/editionsbycategory?cat_id=%@&ed_date=%@",getCatId,[dateFormater stringFromDate:_datePIcker.date]];
    NSLog(@"%@",urlString);
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                NSLog(@"RESPONSE: %@",response);
                NSLog(@"DATA: %@",data);
                
                if (!error) {
                    // Success
                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                        NSError *jsonError;
                        self->dicEditionId = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                        
                        if (jsonError) {
                            // Error Parsing JSON
                            
                        } else {
                            // Success Parsing JSON
                            // Log NSDictionary response:
                            NSLog(@"%@",self->dicEditionId);
                            
                           NSString *passEdId =[[[self->dicEditionId valueForKey:@"data"] objectAtIndex:0] valueForKey:@"ed_id"];
                           
                            
    ReadPaperViewController *readPaper =[self.storyboard instantiateViewControllerWithIdentifier:@"ReadPaperViewController"];
    readPaper.edId=passEdId;
    [self presentViewController:readPaper animated:YES completion:nil];
                           
       
                    [self.spinner stopAnimating];
                            self->_spinner.hidden=YES;
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

- (IBAction)BtnBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
