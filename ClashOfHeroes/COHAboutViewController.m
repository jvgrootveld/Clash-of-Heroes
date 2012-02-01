//
//  COHAboutViewController.m
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 2/1/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "COHAboutViewController.h"
#import "UIView+AlertAnimations.h"
#import <QuartzCore/QuartzCore.h>

@interface COHAboutViewController()

@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, retain) NSString *messageString;
@property (nonatomic, retain) MFMailComposeViewController *mailComposer;

- (void)aboutDidFadeOut;

@end

@implementation COHAboutViewController

@synthesize backgroundImageView = _backgroundImageView;
@synthesize aboutView = _aboutView;
@synthesize titleLabel = _titleLabel;
@synthesize textView = _textView;
@synthesize delegate = _delegate;
@synthesize titleString = _titleString;
@synthesize messageString = _messageString;
@synthesize tag = _tag;
@synthesize mailComposer = _mailComposer;

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message forView:(UIView *)view;
{
    if (self = [super init])
    {
        self.titleString = title;
        self.messageString = message;
        self.view.frame = view.frame;
        self.view.center = view.center;
    }
    
    return self;
}

- (void)show
{
    [self retain];
    
    [self.titleLabel setText:self.titleString];
    [self.textView setText:self.messageString];
    
    //id appDelegate = [[UIApplication sharedApplication] delegate];
    //[[appDelegate window] addSubview:self.view];
    
    [self.aboutView doPopInAnimationWithDelegate:self];
    [self.backgroundImageView doFadeInAnimation];
}

- (void)aboutDidFadeOut;
{    
    [self.view removeFromSuperview];
    [self autorelease];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];   
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
    [self setAboutView:nil];
    [self setTitleLabel:nil];
    [self setTextView:nil];
    [self setDelegate:nil];
    [self setTitleString:nil];
    [self setMessageString:nil];
    [self setMailComposer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc 
{
    [self.backgroundImageView release];
    [self.aboutView release];
    [self.titleLabel release];
    [self.textView release];
    [self.titleString release];
    [self.messageString release];
    [self.mailComposer release];
    [super dealloc];
}

- (IBAction)okButtonPressed:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    self.view.alpha = 0.0;
    [UIView commitAnimations];
    
    [self performSelector:@selector(aboutDidFadeOut) withObject:nil afterDelay:0.5];
    
    [self.delegate aboutView:self wasDismissedWithButtonIndex:((UIButton *)sender).tag];
}

- (IBAction)openFeedBack:(id)sender
{
    self.mailComposer = [MFMailComposeViewController new];
    if ([MFMailComposeViewController canSendMail]) {
        [self.mailComposer setSubject:@"Feedback Clash of Heroes"];
        [self.mailComposer setMailComposeDelegate:self];
        [self.mailComposer setToRecipients:[NSArray arrayWithObject:@"info@tempest.nl"]];
        
        [self presentModalViewController:self.mailComposer animated:NO];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{ 
    [self dismissModalViewControllerAnimated:YES];
}
@end
