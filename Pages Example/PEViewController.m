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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePageWithPageControl:(id)sender {
    
    self.usedPageControlForScrolling = YES;
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.scrollView.contentSize.width / self.pageControl.numberOfPages * self.pageControl.currentPage;
    [UIView animateWithDuration:.25
                     animations:^{
                         self.scrollView.contentOffset = offset;
                     }
                     completion:^(BOOL finished){
                         self.usedPageControlForScrolling = NO;
                     }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!self.usedPageControlForScrolling)
        self.pageControl.currentPage = lround(self.scrollView.contentOffset.x /
                                              (self.scrollView.contentSize.width / self.pageControl.numberOfPages));
}

@end
