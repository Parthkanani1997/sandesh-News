//
//  HomePageViewController.m
//  Sandesh News
//
//  Created by om technology on 06/01/1941 Saka.
//  Copyright © 1941 Panini Academy. All rights reserved.
//

#import "HomePageViewController.h"
#import "DatePageViewController.h"
#import "JsonOperation.h"
@interface HomePageViewController ()

@end

@implementation HomePageViewController
@synthesize tableViewEdition;
- (void)viewDidLoad {
    [super viewDidLoad];
    tableViewEdition.delegate=self;
    tableViewEdition.dataSource=self;
    
    
    
    
    
    dicSandeshCategoies=[[NSMutableDictionary alloc]init];
    ArryEdition=[[NSMutableArray alloc]init];
    Arrycatid=[[NSMutableArray alloc]init ];
    
    JsonOperation *ob=[[JsonOperation alloc]init];
    [ob getJsonFormAPI:@"https://epaper.sandesh.com/main/categories"];
   [ob isJsonCome];
  NSLog(@"%@",ob.dicJSon);
    dicSandeshCategoies=ob.dicJSon;
    NSLog(@"%@",dicSandeshCategoies);
 
    NSMutableArray *arryAllData=[[NSMutableArray alloc]init];
    NSMutableArray *arryChildrenData=[[NSMutableArray alloc]init];

    arryAllData=[dicSandeshCategoies valueForKey:@"data"];

    for (int i=0; i<arryAllData.count; i++)
        {
         arryChildrenData=[[[dicSandeshCategoies valueForKey:@"data"]objectAtIndex:i ]valueForKey:@"children"];
                for (int j=0; j<arryChildrenData.count; j++)
                        {
                        [ArryEdition addObject:[[arryChildrenData objectAtIndex:j]valueForKey:@"ed_title"]];
                        [Arrycatid addObject:[[arryChildrenData objectAtIndex:j]valueForKey:@"cat_id"]];
                           }
                            
        }
    dispatch_async(dispatch_get_main_queue(), ^{

    [self->tableViewEdition reloadData];
    [self->tableViewEdition scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                   });

}
     //table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
  {
      return ArryEdition.count;
  }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

  {
      UITableViewCell *editionCell=[tableView dequeueReusableCellWithIdentifier:@"editionCell"];
      UILabel *lbleditionName=[editionCell viewWithTag:100];
      NSLog(@"%@",[ArryEdition objectAtIndex:indexPath.row]);
      lbleditionName.text=[ArryEdition objectAtIndex:indexPath.row];
      [editionCell.contentView addSubview:lbleditionName];
      return editionCell;
  }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
   {
       DatePageViewController *datePage=[self.storyboard instantiateViewControllerWithIdentifier:@"DatePageViewController"];
      
       datePage.getEditionName=[ArryEdition objectAtIndex:indexPath.row]; //pass edition Name
       
       datePage.getCatId=[Arrycatid objectAtIndex:indexPath.row]; //Pass  cat id
       
       
       [self.navigationController pushViewController:datePage animated:YES];
   }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
  {
      return 80.00;
  }
@end
