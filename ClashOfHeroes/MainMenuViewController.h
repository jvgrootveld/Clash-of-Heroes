//
//  MainMenuViewController.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 28-11-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameCenterManager.h"

@class GameViewController;
@class CDStats;

@interface MainMenuViewController : UIViewController <GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate>
{
    IBOutlet UILabel *playerNameLabel;
    IBOutlet UILabel *gamesWonLabel;
    IBOutlet UILabel *gamesPlayedLabel;
    IBOutlet UILabel *damageDealtName;
    IBOutlet UILabel *damageTakenLabel;
    IBOutlet UILabel *metersMovedLabel;
}

@property (retain, nonatomic) IBOutlet UIButton *startButton;
@property (retain, nonatomic) IBOutlet UIButton *continueButton;
@property (retain, nonatomic) IBOutlet UIButton *settingsButton;
@property (retain, nonatomic) IBOutlet UIButton *feedbackButton;
@property (nonatomic, retain) GameViewController *gameViewController;
@property (nonatomic, retain) NSString* currentLeaderBoard;
@property (retain, nonatomic) IBOutlet UIButton *achievementsButton;
@property (retain, nonatomic) IBOutlet UIButton *LeaderboardButton;
@property (retain, nonatomic) IBOutlet UIButton *FeedbackButton;

- (IBAction)startGameButtonClicked:(id)sender;
- (void)presentGameView;
- (void)presentNewGameView;
- (void)updateStatsWithName:(NSString *)playerName andStats:(CDStats *)stats;
- (IBAction)showLeaderboard:(id)sender;
- (IBAction)showAchievements:(id)sender;
- (IBAction)openFeedBack:(id)sender;

@end
