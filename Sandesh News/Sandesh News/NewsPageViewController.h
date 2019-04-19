//
//  NewsPageViewController.h
//  Sandesh News
//
//  Created by om technology on 08/01/1941 Saka.
//  Copyright © 1941 Panini Academy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsPageViewController : UIViewController
  {
      UIPinchGestureRecognizer *twoFingerPinch;
  }

@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIImageView *imgPage;
- (IBAction)btnBack:(id)sender;
@property NSString *imgPageString;
- (IBAction)pinchImgZoom:(UIPinchGestureRecognizer *)sender;


@end
