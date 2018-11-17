//
//  RootViewController.m
//  WaterfallLearn1
//
//  Created by xiaoyulong on 2017/5/22.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
#import "FlipsideViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

//@synthesize infoButton;
@synthesize flipsideNavigationBar;
@synthesize mainViewController;
@synthesize flipsideViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MainViewController *viewController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
    self.mainViewController = viewController;
    
    
    [self.view insertSubview:mainViewController.view belowSubview:infoButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadFlipsideViewController {
    
    FlipsideViewController *viewController = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    self.flipsideViewController = viewController;
//    [viewController release];
    
    // Set up the navigation bar
    UINavigationBar *aNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    aNavigationBar.barStyle = UIBarStyleBlackOpaque;
    self.flipsideNavigationBar = aNavigationBar;
//    [aNavigationBar release];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toggleView)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Waterfall"];
    navigationItem.rightBarButtonItem = buttonItem;
    [flipsideNavigationBar pushNavigationItem:navigationItem animated:NO];
//    [navigationItem release];
//    [buttonItem release];
}


- (IBAction)toggleView {
    /*
     This method is called when the info or Done button is pressed.
     It flips the displayed view from the main view to the flipside view and vice-versa.
     */
    if (flipsideViewController == nil) {
        [self loadFlipsideViewController];
    }
    
    UIView *mainView = mainViewController.view;
    UIView *flipsideView = flipsideViewController.view;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:([mainView superview] ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
    
    if ([mainView superview] != nil) {
        [flipsideViewController viewWillAppear:YES];
        [mainViewController viewWillDisappear:YES];
        [mainView removeFromSuperview];
        [infoButton removeFromSuperview];
        [self.view addSubview:flipsideView];
        [self.view insertSubview:flipsideNavigationBar aboveSubview:flipsideView];
        [mainViewController viewDidDisappear:YES];
        [flipsideViewController viewDidAppear:YES];
        
    } else {
        [mainViewController viewWillAppear:YES];
        [flipsideViewController viewWillDisappear:YES];
        [flipsideView removeFromSuperview];
        [flipsideNavigationBar removeFromSuperview];
        [self.view addSubview:mainView];
        [self.view insertSubview:infoButton aboveSubview:mainViewController.view];
        [flipsideViewController viewDidDisappear:YES];
        [mainViewController viewDidAppear:YES];
    }
    [UIView commitAnimations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
//    [infoButton release];
//    [flipsideNavigationBar release];
//    [mainViewController release];
//    [flipsideViewController release];
//    [super dealloc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
