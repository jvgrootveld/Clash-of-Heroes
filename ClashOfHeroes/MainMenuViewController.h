//
//  MainMenuViewController.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 28-11-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameViewController;
@class CDStats;

@interface MainMenuViewController : UIViewController
{
    IBOutlet UILabel *playerNameLabel;
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

- (IBAction)startGameButtonClicked:(id)sender;
- (void)presentGameView;
- (void)presentNewGameView;
- (void)updateStatsWithName:(NSString *)playerName andStats:(CDStats *)stats;

@end
