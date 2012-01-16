//
//  GameViewController.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 22-11-11.
//  Copyright Pro4all 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;
@class GameLayer;

@interface GameViewController : UIViewController <UIAlertViewDelegate>

@property (retain, nonatomic) IBOutlet UILabel *playerOneLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerTwoLabel;
@property (retain, nonatomic) IBOutlet UILabel *phaseLabel;
@property (nonatomic, strong) GameLayer *gameLayer;

- (void)updateLabels;
- (IBAction)endTurn:(id)sender;
- (IBAction)endPhase:(id)sender;

@end
