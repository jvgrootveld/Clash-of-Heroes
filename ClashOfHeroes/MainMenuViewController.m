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
#import "CDStats.h"
#import "GameLayer.h"
#import "AppSpecificValues.h"
#import "GameCenterManager.h"

@implementation MainMenuViewController
@synthesize startButton;
@synthesize continueButton;
@synthesize settingsButton;
@synthesize feedbackButton;
@synthesize gameViewController = _gameViewController;
@synthesize currentLeaderBoard = _currentLeaderBoard;

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
    
    CCScene *scene = [CCDirector sharedDirector].runningScene;
    
    for(CCLayer *layer in scene.children)
    {
        if([layer isKindOfClass:[GameLayer class]]) [(GameLayer *)layer loadUnitLocations];
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
    
    self.currentLeaderBoard = kLeaderboardID;
    
    if ([GameCenterManager isGameCenterAvailable]) 
    {
        GameCenterManager *gameCenterManager = [GameCenterManager sharedInstance];
        [gameCenterManager setDelegate:[GCTurnBasedMatchHelper sharedInstance]];
        [gameCenterManager authenticateLocalUser];
        
    } else {
        
        // The current device does not support Game Center.
        
    }
}

- (void)viewDidUnload
{
    [self setStartButton:nil];
    [self setContinueButton:nil];
    [self setSettingsButton:nil];
    [self setFeedbackButton:nil];
    self.currentLeaderBoard = nil;
    
    [playerNameLabel release];
    [gamesPlayedLabel release];
    [damageDealtName release];
    [damageTakenLabel release];
    [metersMovedLabel release];
    metersMovedLabel = nil;
    [gamesWonLabel release];
    gamesWonLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.continueButton setEnabled:[[GKLocalPlayer localPlayer] isAuthenticated]];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)updateStatsWithName:(NSString *)playerName andStats:(CDStats *)stats
{
    [playerNameLabel setText:playerName];
    
    if(stats)
    {
        [gamesPlayedLabel setText:[NSString stringWithFormat:@"%d", [stats totalGamesPlayed]]];
        [gamesWonLabel setText:[NSString stringWithFormat:@"%d", stats.gamesWon.integerValue]];
        [damageDealtName setText:[NSString stringWithFormat:@"%d", stats.totalDamageDealt.integerValue]];
        [damageTakenLabel setText:[NSString stringWithFormat:@"%d", stats.totalDamageTaken.integerValue]];
        [metersMovedLabel setText:[NSString stringWithFormat:@"%d", stats.totalMetersMoved.integerValue]];
    }
    else
    {
        [gamesPlayedLabel setText:@""];
        [gamesWonLabel setText:@""];
        [damageDealtName setText:@""];
        [damageTakenLabel setText:@""];
        [metersMovedLabel setText:@""];
    }
}

- (void)dealloc 
{
    [startButton release];
    [continueButton release];
    [settingsButton release];
    [feedbackButton release];
    [playerNameLabel release];
    [gamesPlayedLabel release];
    [damageDealtName release];
    [damageTakenLabel release];
    [metersMovedLabel release];
    [gamesWonLabel release];
    [self.currentLeaderBoard release];
    [super dealloc];
}

- (IBAction)startGameButtonClicked:(id)sender
{
    [[GCTurnBasedMatchHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:2 viewController:self];
}

#pragma mark - Leaderboard delegate
- (IBAction)showLeaderboard:(id)sender
{
    GKLeaderboardViewController *leaderboardController = [GKLeaderboardViewController new];
    if (leaderboardController != NULL)
    {
        leaderboardController.category = self.currentLeaderBoard;
        leaderboardController.timeScope = GKLeaderboardTimeScopeWeek;
        leaderboardController.leaderboardDelegate = self;
        [self presentModalViewController: leaderboardController animated: YES];
    }
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self dismissModalViewControllerAnimated: YES];
    [viewController release];
}

#pragma mark - Achievement delegate
- (IBAction)showAchievements:(id)sender
{
    GKAchievementViewController *achievements = [GKAchievementViewController new];
    if (achievements != NULL)
    {
        achievements.achievementDelegate = self;
        [self presentModalViewController: achievements animated: YES];
    }
}

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController;
{
    [self dismissModalViewControllerAnimated: YES];
    [viewController release];
}
@end
