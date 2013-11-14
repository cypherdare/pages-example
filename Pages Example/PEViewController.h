//
//  PEViewController.h
//  Pages Example
//
//  Created by Darren Keese on 11/12/13.
//  Copyright (c) 2013 Pages. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PEViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *firstView; //The other three views are sized to the first view, so it is the only one that must be adjusted to fit the device's screen size. The scroll view also fits to this view's height.
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstViewWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageControlHeightConstraint;

@end
