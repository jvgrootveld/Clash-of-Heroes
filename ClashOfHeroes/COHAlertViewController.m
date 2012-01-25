//
//  COHAlertViewController.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 20-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "COHAlertViewController.h"
#import "UIView+AlertAnimations.h"
#import <QuartzCore/QuartzCore.h>

@interface COHAlertViewController()

@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, retain) NSString *messageString;

- (void)alertDidFadeOut;

@end

@implementation COHAlertViewController
@synthesize backgroundImageView;
@synthesize alertView;
@synthesize titleLabel;
@synthesize messageLabel;
@synthesize delegate;
@synthesize titleString;
@synthesize messageString;
@synthesize tag = _tag;

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message
{
    if (self = [super init])
    {
        self.titleString = title;
        self.messageString = message;
    }
    
    return self;
}

- (void)show
{
    [self retain];
    
    [self.titleLabel setText:self.titleString];
    [self.messageLabel setText:self.messageString];
    
    //id appDelegate = [[UIApplication sharedApplication] delegate];
    //[[appDelegate window] addSubview:self.view];
    
    [self.alertView doPopInAnimationWithDelegate:self];
    [self.backgroundImageView doFadeInAnimation];
}

- (IBAction)dismiss:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    self.view.alpha = 0.0;
    [UIView commitAnimations];
    
    [self performSelector:@selector(alertDidFadeOut) withObject:nil afterDelay:0.5];

    [delegate alertView:self wasDismissedWithButtonIndex:((UIButton *)sender).tag];
}

- (void)alertDidFadeOut
{    
    [self.view removeFromSuperview];
    [self autorelease];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setBackgroundImageView:nil];
    [self setAlertView:nil];
    [self setTitleLabel:nil];
    [self setMessageLabel:nil];
    [self setDelegate:nil];
    [self setMessageString:nil];
    [self setTitleString:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc {
    [backgroundImageView release];
    [alertView release];
    [titleLabel release];
    [messageLabel release];
    [messageString release];
    [titleString release];
    
    [super dealloc];
}
@end
