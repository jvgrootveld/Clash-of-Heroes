//
//  MainMenuViewController.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 28-11-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "MainMenuViewController.h"
#import "AppDelegate.h"
#import "GCTurnBasedMatchHelper.h"
#import "GameViewController.h"
#import "NewGameViewController.h"

@implementation MainMenuViewController
@synthesize startButton;
@synthesize continueButton;
@synthesize settingsButton;
@synthesize feedbackButton;
@synthesize gameViewController = _gameViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)presentNewGameView
{
    NewGameViewController *newGameViewController = [[NewGameViewController new] autorelease];
    [self.navigationController pushViewController:newGameViewController animated:NO];
}

- (void)presentGameView
{
    if (_gameViewController == nil)
    {
        self.gameViewController = [[GameViewController new] autorelease];
    }
    
    [self.navigationController pushViewController:self.gameViewController animated:NO];
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
    
    [[GCTurnBasedMatchHelper sharedInstance] setMainMenu:self];
}

- (void)viewDidUnload
{
    [self setStartButton:nil];
    [self setContinueButton:nil];
    [self setSettingsButton:nil];
    [self setFeedbackButton:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc {
    [startButton release];
    [continueButton release];
    [settingsButton release];
    [feedbackButton release];
    [super dealloc];
}

- (IBAction)startGameButtonClicked:(id)sender
{
    [[GCTurnBasedMatchHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:2 viewController:self];
}
@end
