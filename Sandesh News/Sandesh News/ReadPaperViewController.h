//
//  ReadPaperViewController.h
//  Sandesh News
//
//  Created by om technology on 07/01/1941 Saka.
//  Copyright © 1941 Panini Academy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadPaperViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lblEditionID;
@property (weak, nonatomic) IBOutlet UITableView *tablePages;
@property  NSString *edId;
@property NSDictionary *dicJson;
@property NSMutableArray *arryPages;
- (IBAction)btnBack:(id)sender;
@end
