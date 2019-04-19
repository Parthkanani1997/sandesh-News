//
//  NewsPageViewController.m
//  Sandesh News
//
//  Created by om technology on 08/01/1941 Saka.
//  Copyright © 1941 Panini Academy. All rights reserved.
//

#import "NewsPageViewController.h"

@interface NewsPageViewController ()

@end

@implementation NewsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   _imgPage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgPageString]]];
    
}
- (IBAction)pinchGestureDidFire:(UIPinchGestureRecognizer *)pinch {
    UIView *pinchView = pinch.view;
    CGRect bounds = pinchView.bounds;
    CGPoint pinchCenter = [pinch locationInView:pinchView];
    pinchCenter.x -= CGRectGetMidX(bounds);
    pinchCenter.y -= CGRectGetMidY(bounds);
    CGAffineTransform transform = pinchView.transform;
    transform = CGAffineTransformTranslate(transform, pinchCenter.x, pinchCenter.y);
    CGFloat scale = pinch.scale;
    transform = CGAffineTransformScale(transform, scale, scale);
    transform = CGAffineTransformTranslate(transform, -pinchCenter.x, -pinchCenter.y);
    pinchView.transform = transform;
    pinch.scale = 1.0;
}


- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
   
}

@end
