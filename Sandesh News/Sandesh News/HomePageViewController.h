//
//  HomePageViewController.h
//  Sandesh News
//
//  Created by om technology on 06/01/1941 Saka.
//  Copyright © 1941 Panini Academy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
  {
      NSMutableDictionary *dicSandeshCategoies;
      NSMutableArray *ArryEdition;
      NSMutableArray *Arrycatid;
  }



@property (weak, nonatomic) IBOutlet UITableView *tableViewEdition;

@end
