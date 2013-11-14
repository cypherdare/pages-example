//
//  PEViewController.m
//  Pages Example
//
//  Created by Darren Keese on 11/12/13.
//  Copyright (c) 2013 Pages. All rights reserved.
//

#import "PEViewController.h"

@interface PEViewController ()

@property (nonatomic) BOOL usedPageControlForScrolling;

@end

@implementation PEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.scrollView.delegate = self;
    self.usedPageControlForScrolling = NO;
    
    CGSize windowSize = [UIApplication sharedApplication].delegate.window.bounds.size;
    CGFloat pageControlHeight = self.pageControlHeightConstraint.constant;
    self.firstViewHeightConstraint.constant = windowSize.height - pageControlHeight;
    self.firstViewWidthConstraint.constant = windowSize.width;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePageWithPageControl:(id)sender {
    [self setScrollViewToMatchPageControlWithDuration:0.25];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!self.usedPageControlForScrolling)
        self.pageControl.currentPage = lround(self.scrollView.contentOffset.x /
                                              (self.scrollView.contentSize.width / self.pageControl.numberOfPages));
}

-(void) setScrollViewToMatchPageControlWithDuration:(NSTimeInterval)duration {
    self.usedPageControlForScrolling = YES;
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.scrollView.contentSize.width / self.pageControl.numberOfPages * self.pageControl.currentPage;
    [UIView animateWithDuration: duration
                     animations:^{
                         self.scrollView.contentOffset = offset;
                     }
                     completion:^(BOOL finished){
                         self.usedPageControlForScrolling = NO;
                     }];
    
}

-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self updateConstraintsForInterfaceOrientation:toInterfaceOrientation];
    [self setScrollViewToMatchPageControlWithDuration:0.25];
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self updateConstraintsForInterfaceOrientation:toInterfaceOrientation];
    [self setScrollViewToMatchPageControlWithDuration:0.25];
}

-(void) updateConstraintsForInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    CGSize windowSize = [UIApplication sharedApplication].delegate.window.bounds.size;
    CGFloat destinationHeight, destinationWidth;
    
    switch (toInterfaceOrientation){
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            destinationHeight = MAX(windowSize.height, windowSize.width);
            destinationWidth = MIN(windowSize.height, windowSize.width);
            break;
        default:
            destinationHeight = MIN(windowSize.height, windowSize.width);
            destinationWidth = MAX(windowSize.height, windowSize.width);
            break;
    }
    
    CGFloat pageControlHeight = self.pageControlHeightConstraint.constant;
    
    self.firstViewHeightConstraint.constant = destinationHeight - pageControlHeight;
    self.firstViewWidthConstraint.constant = destinationWidth;
    
    [self.view layoutIfNeeded];
    
}

@end
