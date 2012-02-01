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
#import "CDPlayer.h"
#import <MessageUI/MessageUI.h>
#import "COHAboutViewController.h"

@interface MainMenuViewController()

@property (nonatomic, strong) MFMailComposeViewController *mailComposer;

@end

@implementation MainMenuViewController
@synthesize startButton;
@synthesize continueButton;
@synthesize settingsButton;
@synthesize feedbackButton;
@synthesize gameViewController = _gameViewController;
@synthesize currentLeaderBoard = _currentLeaderBoard;
@synthesize achievementsButton;
@synthesize LeaderboardButton;
@synthesize FeedbackButton;
@synthesize mailComposer = _mailComposer;

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
    [self setAchievementsButton:nil];
    [self setLeaderboardButton:nil];
    [self setFeedbackButton:nil];
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if([GKLocalPlayer localPlayer].isAuthenticated)
    {
        CDPlayer *player = [StatsController playerForGameCenterId:[GKLocalPlayer localPlayer].playerID];
        if(!player) player = [StatsController newPlayerAndStatsForPlayerWithGameCenterId:[GKLocalPlayer localPlayer].playerID]; //new user
        
        [self updateStatsWithName:[GKLocalPlayer localPlayer].alias andStats:(CDStats *)player.stats];
    }
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
    [achievementsButton release];
    [LeaderboardButton release];
    [FeedbackButton release];
    [self.mailComposer release];
    [super dealloc];
}

- (IBAction)startGameButtonClicked:(id)sender
{
    [[GCTurnBasedMatchHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:2 viewController:self];
}

- (IBAction)aboutButtonPressed:(id)sender
{
    COHAboutViewController *aboutView = [[COHAboutViewController alloc] initWithTitle:@"About" andMessage:@"Tempest Mobile is a development team based in Rotterdam, the Netherlands. This product was made as a part of an assignment for the Rotterdam University.\n\nIf you have any issues or suggestions for improving this product, use the Feedback-button below to contact us." forView:self.view];
    
    [aboutView setTag:3];
    [aboutView setDelegate:self];
    [self.view addSubview:aboutView.view];
    [aboutView show];
}

#pragma mark - AboutViewController Delegate
- (void)aboutView:(COHAboutViewController *)about wasDismissedWithButtonIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark - Leaderboard delegate
- (IBAction)showLeaderboard:(id)sender
{
    GKLeaderboardViewController *leaderboardController = [GKLeaderboardViewController new];
    if (leaderboardController != NULL)
    {
        leaderboardController.category = kLeaderboardID;
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
