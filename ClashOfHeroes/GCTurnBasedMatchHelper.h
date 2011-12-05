//
//  GCTurnBasedMatchHelper.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 24-11-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCTurnBasedMatchHelper : NSObject <GKTurnBasedMatchmakerViewControllerDelegate> {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    UIViewController *presentingViewController;
}

@property (assign, readonly) BOOL gameCenterAvailable;
@property (retain) GKTurnBasedMatch * currentMatch;

- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewController:(UIViewController *)viewController;
+ (GCTurnBasedMatchHelper *)sharedInstance;
- (void)authenticateLocalUser;

@end
