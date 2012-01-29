//
//  GameViewController.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 22-11-11.
//  Copyright Pro4all 2011. All rights reserved.
//

//
// RootViewController + iAd
// If you want to support iAd, use this class as the controller of your iAd
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "GameViewController.h"
#import "GameConfig.h"
#import "GameLayer.h"
#import "GCTurnBasedMatchHelper.h"
#import "Turn.h"
#import "Player.h"
#import "COHAlertViewController.h"
#import "Phase.h"
#import "MovementPhase.h"
#import "CombatPhase.h"

@implementation GameViewController
@synthesize playerOneLabel;
@synthesize playerTwoLabel;
@synthesize phaseLabel;
@synthesize movesLabel;
@synthesize gameLayer = _gameLayer;

- (void)setupCocos2D 
{
    EAGLView *glView = [EAGLView viewWithFrame:self.view.bounds
                                   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
                                   depthFormat:0                        // GL_DEPTH_COMPONENT16_OES
                        ];
    glView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:glView atIndex:0];
    [[CCDirector sharedDirector] setOpenGLView:glView];
    [[CCDirector sharedDirector] runWithScene:[GameLayer sceneWithDelegate:self]];
}

- (void)updateLabels
{
    Player *playerOne = [[GCTurnBasedMatchHelper sharedInstance] playerForLocalPlayer];
    Player *playerTwo = [[GCTurnBasedMatchHelper sharedInstance] playerForEnemyPlayer];
    
    if(playerOne) [playerOneLabel setText:playerOne.gameCenterInfo.alias];
    if(playerTwo) [playerOneLabel setText:playerTwo.gameCenterInfo.alias];
    
    [phaseLabel setText:[self.gameLayer.currentPhase description]];
    [movesLabel setText:[NSString stringWithFormat:@"Remaining moves: %d", self.gameLayer.currentPhase.remainingMoves]];
    
}

- (IBAction)endTurn:(id)sender {
    COHAlertViewController *alertView = [[COHAlertViewController alloc] initWithTitle:@"End turn" andMessage:@"Are you sure you want to end this turn? This will cancel any remaining moves."];
    
    alertView.view.frame = self.view.frame;
    alertView.view.center = self.view.center;
    [alertView setTag:1];
    [alertView setDelegate:self];
    [self.view addSubview:alertView.view];
    [alertView show];
}

- (IBAction)endPhase:(id)sender {    
    COHAlertViewController *alertView = [[COHAlertViewController alloc] initWithTitle:@"End phase" andMessage:@"Are you sure you want to end this phase? This will cancel any remaining moves."];
    alertView.view.frame = self.view.frame;
    alertView.view.center = self.view.center;
    [alertView setTag:2];
    [alertView setDelegate:self];
    [self.view addSubview:alertView.view];
    [alertView show];
}

- (IBAction)backButtonPressed:(id)sender {
    COHAlertViewController *alertView = [[COHAlertViewController alloc] initWithTitle:@"Back to menu" andMessage:@"Are you sure you want to quit? This will revert any moves you have made."];
    
    alertView.view.frame = self.view.frame;
    alertView.view.center = self.view.center;
    [alertView setTag:3];
    [alertView setDelegate:self];
    [self.view addSubview:alertView.view];
    [alertView show];
}

#pragma mark - COHAlertView delegate

- (void)alertView:(COHAlertViewController *)alert wasDismissedWithButtonIndex:(NSInteger)buttonIndex;
{
    NSLog(@"buttonindex: %d", buttonIndex);
    if (buttonIndex == 2)
    {
        if (alert.tag == 1)
        {
            Turn *lastTurn = [Turn new];
            
            NSMutableDictionary *move = [NSMutableDictionary dictionary];
            [move setValue:@"piece 24" forKey:@"piece"];
            
            NSMutableDictionary *action = [NSMutableDictionary dictionary];
            [action setValue:@"Attack" forKey:@"action"];
            
            [lastTurn.movements addObject:move];
            [lastTurn.actions addObject:action];
            
            [[GCTurnBasedMatchHelper sharedInstance] endTurn:lastTurn];
        }
        else if (alert.tag == 2)
        {
            [self.gameLayer.currentPhase endPhase];
        }
        else if (alert.tag == 3)
            [self.navigationController popViewControllerAnimated:YES];
    }
    
    //[self updateLabels];
}

#pragma mark - View lifecycle

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];    
    [self setupCocos2D];
    
    [[GCTurnBasedMatchHelper sharedInstance] setGameViewController:self];
    [self updateLabels];
    
    if (![[GCTurnBasedMatchHelper sharedInstance] localPlayerIsCurrentParticipant])
    {
        COHAlertViewController *alertView = [[COHAlertViewController alloc] initWithTitle:@"Waiting for player" andMessage:@"Waiting for your opponent to make his move."];
        
        alertView.view.frame = self.view.frame;
        alertView.view.center = self.view.center;
        [alertView setTag:3];
        [alertView setDelegate:self];
        [self.view addSubview:alertView.view];
        [alertView show];
    }
}


- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [self setPlayerOneLabel:nil];
    [self setPlayerTwoLabel:nil];
    [self setPhaseLabel:nil];
    [self setMovesLabel:nil];
    [super viewDidUnload];
    
    [[CCDirector sharedDirector] end];
}


- (void)dealloc {
    [playerOneLabel release];
    [playerTwoLabel release];
    [phaseLabel release];
    [movesLabel release];
    [super dealloc];
}


@end

