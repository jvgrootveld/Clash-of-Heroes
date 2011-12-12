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

@implementation GameViewController
@synthesize playerOneLabel;
@synthesize playerTwoLabel;

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
    GKPlayer *playerOne = (GKPlayer *)[[[GCTurnBasedMatchHelper sharedInstance] currentPlayers] objectAtIndex:0];
    GKPlayer *playerTwo = (GKPlayer *)[[[GCTurnBasedMatchHelper sharedInstance] currentPlayers] objectAtIndex:1];
    
    [playerOneLabel setText:playerOne.alias];
    [playerTwoLabel setText:playerTwo.alias];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    [self setupCocos2D];
    
    [[GCTurnBasedMatchHelper sharedInstance] setGameViewController:self];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [self setPlayerOneLabel:nil];
    [self setPlayerTwoLabel:nil];
    [super viewDidUnload];
    
    [[CCDirector sharedDirector] end];
}


- (void)dealloc {
    [playerOneLabel release];
    [playerTwoLabel release];
    [super dealloc];
}


@end

