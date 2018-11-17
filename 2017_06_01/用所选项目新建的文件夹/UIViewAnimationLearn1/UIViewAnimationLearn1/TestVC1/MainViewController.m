#import "MainViewController.h"

@implementation MainViewController

@synthesize animImageView;
@synthesize button;

- (IBAction)action:(id)sender {
  [UIView beginAnimations:@"Hide Button" context:nil];
  [[self button] setAlpha:0.0];
  [UIView commitAnimations];
  
  [UIView beginAnimations:@"Slide Around" context:nil];
  
  [UIView setAnimationDuration:1.0];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(viewAnimationDone:)];
  [UIView setAnimationRepeatCount:3];
  [UIView setAnimationRepeatAutoreverses:YES];
  
  CGPoint center = [[self animImageView] center];
  center.y += 100;
  
  [[self animImageView] setCenter:center];
  
  [UIView commitAnimations];
}

- (void)viewAnimationDone:(NSString*)name {
  [UIView beginAnimations:@"Show Button" context:nil];
  [[self button] setAlpha:1.0];
  [UIView commitAnimations];
}

@end