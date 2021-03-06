//
//  MainViewController.m
//  QCMerge2013
//
//  Created by Chris Moore on 4/11/13.
//  Copyright (c) 2013 Gaslight. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    for (UIView *view in self.mainView.subviews)
    {
        if([view isKindOfClass:[UILabel class]])
        {
            UILabel *label = (UILabel*)view;
            label.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:45];
            label.userInteractionEnabled = YES;

            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleLabelTap:)];
            [label addGestureRecognizer:tap];
        }
    }

    [self animateView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animateView
{
    CGRect initialFrame = self.view.frame;
    int logoHeight = 35;
    int height = initialFrame.size.height - logoHeight;

    self.mainView.frame = CGRectMake(0, height * -1, initialFrame.size.width, initialFrame.size.height);

    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.frame = CGRectMake(0, 0, initialFrame.size.width, initialFrame.size.height);
    }];

    CABasicAnimation *bounceAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    bounceAnimation.duration = 0.2;
    bounceAnimation.fromValue = [NSNumber numberWithInt:0];
    bounceAnimation.toValue = [NSNumber numberWithInt:-20];
    bounceAnimation.repeatCount = 2;
    bounceAnimation.autoreverses = YES;
    bounceAnimation.fillMode = kCAFillModeForwards;
    bounceAnimation.removedOnCompletion = NO;
    bounceAnimation.additive = YES;
    [self.mainView.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
}

- (void)handleLabelTap:(UIGestureRecognizer *)gestureRecognizer
{
    UILabel *label = (UILabel *)gestureRecognizer.view;

    if ([label.text isEqualToString:@" TWEET"])
    {
        [self performSegueWithIdentifier:@"showTweets" sender:label];
    } else {
        [self performSegueWithIdentifier:@"showWebView" sender:label];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *title = [sender text];
    [segue.destinationViewController setTitle:[title capitalizedString]];
}
@end
