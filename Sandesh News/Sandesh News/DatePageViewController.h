//
//  DatePageViewController.h
//  Sandesh News
//
//  Created by om technology on 07/01/1941 Saka.
//  Copyright © 1941 Panini Academy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePageViewController : UIViewController
 {
     NSDateFormatter *dateFormater;
     NSMutableDictionary *dicEditionId;
     
     
 }
@property (weak, nonatomic) IBOutlet UILabel *lblEditionName;

- (IBAction)btnGo:(id)sender;
- (IBAction)BtnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property NSString *getEditionName;
@property NSString *getCatId;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePIcker;

@end
