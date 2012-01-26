//
//  NewGameViewController.h
//  ClashOfHeroes
//
//  Created by Nick Vd adel on 08-12-11.
//  Copyright (c) 2011 New Visual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COHAlertViewController.h"

@class MainMenuViewController;

@interface NewGameViewController : UIViewController <COHAlertViewDelegate>

@property (nonatomic, retain) MainMenuViewController *mainMenu;
@property (nonatomic, retain) NSDictionary *heroes;
@property (nonatomic, retain) NSString *chosenHero;
@property (nonatomic, retain) NSDictionary *chosenHeroDictionary;
@property (nonatomic, retain) NSMutableDictionary *chosenAbilities;

@property (nonatomic, readwrite) NSInteger abilityCounter;

// Description outlets
@property (retain, nonatomic) IBOutlet UITextView *DescriptionField;
@property (retain, nonatomic) IBOutlet UITextView *AbilityDescriptionField;

// Hero buttons
@property (retain, nonatomic) IBOutlet UIButton *GarrickButton;
@property (retain, nonatomic) IBOutlet UIButton *GalenButton;
@property (retain, nonatomic) IBOutlet UIButton *EldurinButton;

// Ability outlets
@property (retain, nonatomic) IBOutlet UIButton *Ability1Button;
@property (retain, nonatomic) IBOutlet UIButton *Ability2Button;
@property (retain, nonatomic) IBOutlet UIButton *Ability3Button;
@property (retain, nonatomic) IBOutlet UIButton *Ability4Button;
@property (retain, nonatomic) IBOutlet UIButton *Ability5Button;
@property (retain, nonatomic) IBOutlet UIButton *Ability6Button;
@property (retain, nonatomic) IBOutlet UIButton *Ability7Button;
@property (retain, nonatomic) IBOutlet UIButton *Ability8Button;

// Play
@property (retain, nonatomic) IBOutlet UIButton *PlayButton;

- (IBAction)backButtonPressed:(id)sender;

// Hero actions
- (IBAction)GarrickSelectedEvent:(id)sender;
- (IBAction)GalenSelectedEvent:(id)sender;
- (IBAction)EldurinSelectedEvent:(id)sender;

// Ability actions
- (IBAction)Ability1Action:(id)sender;
- (IBAction)Ability2Action:(id)sender;
- (IBAction)Ability3Action:(id)sender;
- (IBAction)Ability4Action:(id)sender;
- (IBAction)Ability5Action:(id)sender;
- (IBAction)Ability6Action:(id)sender;
- (IBAction)Ability7Action:(id)sender;
- (IBAction)Ability8Action:(id)sender;

// functions
- (void)UpdateAbilitiesAndPassives:(NSString *)sender;
- (void)validateAndSelectAbility:(NSString *)ability andButtonByTag:(NSInteger)tag;
- (void)resetAbilitiesAndPassive;
- (IBAction)goAndPlay:(id)sender;

@end
