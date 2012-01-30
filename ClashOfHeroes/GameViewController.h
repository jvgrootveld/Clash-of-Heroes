//
//  GameViewController.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 22-11-11.
//  Copyright Pro4all 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COHAlertViewController.h"

@class EAGLView;
@class GameLayer;
@class Unit;

@interface GameViewController : UIViewController <COHAlertViewDelegate>

//player one
@property (retain, nonatomic) IBOutlet UILabel *playerOneLabel;
@property (retain, nonatomic) IBOutlet UIImageView *playerOneUnitImageView;
@property (retain, nonatomic) IBOutlet UILabel *playerOneUnitNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerOneUnitHealthLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerOneUnitAttackPowerLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerOneUnitDefenseLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerOneHealthLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerOneAttackLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerOneDefenseLabel;

//player two
@property (retain, nonatomic) IBOutlet UILabel *playerTwoLabel;
@property (retain, nonatomic) IBOutlet UIImageView *playerTwoUnitImageView;
@property (retain, nonatomic) IBOutlet UILabel *playerTwoUnitNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerTwoUnitHealthLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerTwoUnitAttackPowerLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerTwoUnitDefenseLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerTwoHealthLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerTwoAttackLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerTwoDefenseLabel;

@property (retain, nonatomic) IBOutlet UILabel *phaseLabel;
@property (retain, nonatomic) IBOutlet UILabel *movesLabel;
@property (nonatomic, strong) GameLayer *gameLayer;

- (void)updateLabels;
- (void)updatePlayerOneUnit:(Unit *)unit;
- (void)updatePlayerTwoUnit:(Unit *)unit;
- (void)hidePlayerLabels;

- (IBAction)endTurn:(id)sender;
- (IBAction)endPhase:(id)sender;
- (IBAction)backButtonPressed:(id)sender;

@end
