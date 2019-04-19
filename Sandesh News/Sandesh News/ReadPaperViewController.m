//
//  ReadPaperViewController.m
//  Sandesh News
//
//  Created by om technology on 07/01/1941 Saka.
//  Copyright © 1941 Panini Academy. All rights reserved.
//

#import "ReadPaperViewController.h"
#import "NewsPageViewController.h"

@interface ReadPaperViewController ()

@end

@implementation ReadPaperViewController
@synthesize  tablePages;
- (void)viewDidLoad {
    [super viewDidLoad];
    tablePages.delegate=self;
    tablePages.dataSource=self;
  
    _lblEditionID.text=_edId;
    _dicJson=[[NSDictionary alloc]init];
    _arryPages=[[NSMutableArray alloc]init];
    
    
    
    
   NSString *urlString = [NSString stringWithFormat:@"http://epaper.sandesh.com/main/pages?ed_id=%@",_edId];
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
                    if ([response isKindOfClass:[NSHTTPURLResponse class]])
                    {
                        NSError *jsonError;
                        self->_dicJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                         NSMutableArray *_arryPagesDetails=[[NSMutableArray alloc]init];
                         _arryPagesDetails=[self->_dicJson valueForKey:@"data"];
                      for (int i=0; i<_arryPagesDetails.count; i++)
                   {
                            [self->_arryPages addObject:[[_arryPagesDetails objectAtIndex:i]valueForKey:@"pg_file_big"]];
                        }
                        
                        if (jsonError) {
                            // Error Parsing JSON
                            
                        } else {
                            // Success Parsing JSON
                            // Log NSDictionary
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [self->tablePages reloadData];
                                [self->tablePages scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                                });
                            
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
     return _arryPages.count;
 }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellPages = [tableView dequeueReusableCellWithIdentifier:@"cellPages"];
    UIImageView *imgRemote =[cellPages viewWithTag:102];
    imgRemote.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_arryPages objectAtIndex:indexPath.row]]]];
    [cellPages.contentView addSubview:imgRemote];
    
    return cellPages;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 554;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        NewsPageViewController *newsPage =[self.storyboard instantiateViewControllerWithIdentifier:@"NewsPageViewController"];
        newsPage.imgPageString=[_arryPages objectAtIndex:indexPath.row];
        
        [self presentViewController:newsPage animated:YES completion:nil];
    }
     //UIImage *remoteImage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://cdn-img-sandesh-1.phando.com/2019-03/5c9943e061e46.jpg"]]];


- (IBAction)btnBack:(id)sender
 {
     [self dismissViewControllerAnimated:YES completion:nil];
     //   [self.navigationController; popViewControllerAnimated:YES];
 }
@end
