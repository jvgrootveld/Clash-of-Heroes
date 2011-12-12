//
//  MainMenuViewController.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 28-11-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameViewController;

@interface MainMenuViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIButton *startButton;
@property (retain, nonatomic) IBOutlet UIButton *continueButton;
@property (retain, nonatomic) IBOutlet UIButton *settingsButton;
@property (retain, nonatomic) IBOutlet UIButton *feedbackButton;
@property (nonatomic, retain) GameViewController *gameViewController;

- (IBAction)startGameButtonClicked:(id)sender;
- (void)presentGameView;
- (void)presentNewGameView;

@end
