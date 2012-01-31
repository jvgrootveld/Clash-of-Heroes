//
//  NewGameViewController.m
//  ClashOfHeroes
//
//  Created by Nick Vd adel on 08-12-11.
//  Copyright (c) 2011 New Visual. All rights reserved.
//
//if ( [_chosenHero isEqualToString:@"Garrick"] ) {
//    
//} else if ( [_chosenHero isEqualToString:@"Garrick"] ) {
//    
//} else {
//    // eldurin
//}


#import "NewGameViewController.h"
#import "Hero.h"
#import "Player.h"
#import "COHAlertViewController.h"
#import "UnitData.h"
#import "UIImage+UIImage_Grayscale.h"

@implementation NewGameViewController

@synthesize mainMenu = _mainMenu;
@synthesize heroes = _heroes;
@synthesize chosenHero = _chosenHero;
@synthesize chosenAbilities = _chosenAbilities;

@synthesize abilityCounter = _abilityCounter;

@synthesize chosenHeroDictionary = _chosenHeroDictionary;
@synthesize DescriptionField = _DescriptionField;
@synthesize AbilityDescriptionField = _AbilityDescriptionField;
@synthesize GarrickButton = _GarrickButton;
@synthesize GalenButton = _GalenButton;
@synthesize EldurinButton = _EldurinButton;
@synthesize Ability1Button = _Ability1Button;
@synthesize Ability2Button = _Ability2Button;
@synthesize Ability3Button = _Ability3Button;
@synthesize Ability4Button = _Ability4Button;
@synthesize Ability5Button = _Ability5Button;
@synthesize Ability6Button = _Ability6Button;
@synthesize Ability7Button = _Ability7Button;
@synthesize Ability8Button = _Ability8Button;
@synthesize PlayButton = _PlayButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    // UI instellingen doorvoeren
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_garrick.png"]];
    [self.view setOpaque:NO];
    [[self.view layer] setOpaque:NO];
    
    self.heroes = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HeroDescriptions" ofType:@"plist"]];
    
    // Default hero inladen
    self.chosenHero = @"Garrick";
    self.chosenHeroDictionary = [_heroes objectForKey:@"Garrick"];
    
    self.chosenAbilities = [NSMutableDictionary dictionary];
    
    [self resetAbilitiesAndPassive];
    [self.DescriptionField setText:[self.chosenHeroDictionary valueForKey:@"subtitle"]];
    [self.AbilityDescriptionField setText:@"Tap on an ability to find out what it does and to select it. You can only select 4 abilities.\n\nYou can tap on an selected ability button to deselect."];
    
    _abilityCounter = 0;
    
    if (![[GCTurnBasedMatchHelper sharedInstance] localPlayerIsCurrentParticipant])
    {
        COHAlertViewController *alertView = [[COHAlertViewController alloc] initWithTitle:@"Waiting for opponent" andMessage:@"Clash of Heroes is waiting for your opponent to select his hero."];
        
        alertView.view.frame = self.view.frame;
        alertView.view.center = self.view.center;
        [alertView setTag:1];
        [alertView setDelegate:self];
        [self.view addSubview:alertView.view];
        [alertView show];
    }

}

- (void)viewDidUnload
{
    [self setAbility1Button:nil];
    [self setAbility2Button:nil];
    [self setAbility3Button:nil];
    [self setAbility4Button:nil];
    [self setAbility5Button:nil];
    [self setAbility6Button:nil];
    [self setAbility7Button:nil];
    [self setAbility8Button:nil];
    [self setDescriptionField:nil];
    [self setAbilityDescriptionField:nil];
    [self setPlayButton:nil];
    [self setGarrickButton:nil];
    [self setGalenButton:nil];
    [self setEldurinButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)GarrickSelectedEvent:(id)sender {
    self.chosenHeroDictionary = [self.heroes objectForKey:@"Garrick"];
    [self.DescriptionField setText:[self.chosenHeroDictionary valueForKey:@"subtitle"]];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_garrick.png"]];
    
    [self.DescriptionField setText:@"Garrick of the Four Swords \nGarrick is a notorious warrior known for fighting with four swords. His abilities excel in either the protection allies, or devastating melee attacks."];
    
    self.chosenHero = @"Garrick";
    [self UpdateAbilitiesAndPassives:@"Garrick"];
    
    [self.AbilityDescriptionField setText:@""];
    
    [self resetAbilitiesAndPassive];
    
    [self.GalenButton setImage:[UIImage imageNamed:@"hero_galen_gray.png"] forState:UIControlStateNormal];
    [self.EldurinButton setImage:[UIImage imageNamed:@"hero_eldurin_gray.png"] forState:UIControlStateNormal];
    [self.GarrickButton setImage:[UIImage imageNamed:@"hero_garrick.png"] forState:UIControlStateNormal];   
    
}

- (IBAction)GalenSelectedEvent:(id)sender {
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_galen.png"]];
    
    [self.DescriptionField setText:@"Galen earned his nickname 'the Spellslinger' to years of practicing and sharpening his ability with the elemental and arcane powers. As such, he has become a master in the use of Fire, Lightning, Ice and Arcane magics."];
    
    self.chosenHero = @"Galen";
    [self.AbilityDescriptionField setText:@""];
    
    [self resetAbilitiesAndPassive];
    
    [self.GalenButton setImage:[UIImage imageNamed:@"hero_galen.png"] forState:UIControlStateNormal];
    [self.EldurinButton setImage:[UIImage imageNamed:@"hero_eldurin_gray.png"] forState:UIControlStateNormal];
    [self.GarrickButton setImage:[UIImage imageNamed:@"hero_garrick_gray.png"] forState:UIControlStateNormal];    
}

- (IBAction)EldurinSelectedEvent:(id)sender {
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_eldurin.png"]];
    
    [self.DescriptionField setText:@"Eldurin was abandoned when she was young and roamed the streets. It didn't take long before she was adopted by the Church, and learned the ways of the Holy Light. She studied it rigorously, resulting in her title 'the Enlightened'."];
    
    self.chosenHero = @"Eldurin";
    [self.AbilityDescriptionField setText:@""];
    
    [self resetAbilitiesAndPassive];
    
    [self.GalenButton setImage:[UIImage imageNamed:@"hero_galen_gray.png"] forState:UIControlStateNormal];
    [self.EldurinButton setImage:[UIImage imageNamed:@"hero_eldurin.png"] forState:UIControlStateNormal];
    [self.GarrickButton setImage:[UIImage imageNamed:@"hero_garrick_gray.png"] forState:UIControlStateNormal];  
    
}

#pragma validateAndSelectAbility

- (void)validateAndSelectAbility:(NSString *)ability andButtonByTag:(NSInteger) tag {
    NSDictionary *abilityDict = [self.chosenHeroDictionary objectForKey:@"abilities"];

    if (_abilityCounter <= 3 && (![self.chosenAbilities objectForKey:ability]) ) {
        
        [self.chosenAbilities setObject:ability forKey:ability];

        UIButton * button = (UIButton *)[self.view viewWithTag:tag];
        
        [button setImage:[UIImage imageNamed:[[abilityDict objectForKey:ability] valueForKey:@"image"]] forState:UIControlStateNormal];
        
        self.abilityCounter++;
        
    }  else if ([self.chosenAbilities objectForKey:ability]) {

        [self.chosenAbilities removeObjectForKey:ability];
        
        UIButton * button = (UIButton *)[self.view viewWithTag:tag];
        [button setImage:[[UIImage imageNamed:[[abilityDict objectForKey:ability] valueForKey:@"image"]] grayScale] forState:UIControlStateNormal];
        
        self.abilityCounter--;
        
    } else {
        NSLog(@"Teveel gekozen!");
    }
    
}

- (void)resetAbilitiesAndPassive {

    self.chosenAbilities = [NSMutableDictionary dictionary];
    self.abilityCounter = 0;
    
    NSDictionary *abilityDict = [self.chosenHeroDictionary objectForKey:@"abilities"];
    NSArray *allKeys = [abilityDict allKeys];
    
    [self.Ability1Button setImage:[[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:0]] valueForKey:@"image"]] grayScale]
                         forState:UIControlStateNormal];
    [self.Ability2Button setImage:[[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:1]] valueForKey:@"image"]] grayScale]
                         forState:UIControlStateNormal];
    [self.Ability3Button setImage:[[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:2]] valueForKey:@"image"]] grayScale]
                         forState:UIControlStateNormal];
    [self.Ability4Button setImage:[[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:3]] valueForKey:@"image"]] grayScale]
                         forState:UIControlStateNormal];
    [self.Ability5Button setImage:[[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:4]] valueForKey:@"image"]] grayScale]
                         forState:UIControlStateNormal];
    [self.Ability6Button setImage:[[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:5]] valueForKey:@"image"]] grayScale]
                         forState:UIControlStateNormal];
    [self.Ability7Button setImage:[[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:6]] valueForKey:@"image"]] grayScale]
                         forState:UIControlStateNormal];
    [self.Ability8Button setImage:[[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:7]] valueForKey:@"image"]] grayScale]
                         forState:UIControlStateNormal];
    
}

- (IBAction)goAndPlay:(id)sender {
    
    if ( _abilityCounter != 4 ) {
        [self.AbilityDescriptionField setText:@"You must select more abilities."];
    } else {
        COHAlertViewController *alertView = [[COHAlertViewController alloc] initWithTitle:@"Hero selection" andMessage:[NSString stringWithFormat:@"Are you sure you want to select %@ as your hero?", _chosenHero]];
        
        alertView.view.frame = self.view.frame;
        alertView.view.center = self.view.center;
        [alertView setTag:2];
        [alertView setDelegate:self];
        [self.view addSubview:alertView.view];
        [alertView show];
    }
    
}

- (IBAction)abilityButtonPressed:(UIButton *)sender {
    NSDictionary *abilities = [self.chosenHeroDictionary objectForKey:@"abilities"];
    NSString *abilityName = [[abilities allKeys] objectAtIndex:(sender.tag-1)];
    NSDictionary *abilityDict = [abilities objectForKey:abilityName];
    
    [self.AbilityDescriptionField setText:[NSString stringWithFormat:@"%@: %@", abilityName, [abilityDict valueForKey:@"abilityDescription"]]];
    [self validateAndSelectAbility:abilityName andButtonByTag:sender.tag];    
    
}

- (void)dealloc {
    [_Ability1Button release];
    [_Ability2Button release];
    [_Ability3Button release];
    [_Ability4Button release];
    [_Ability5Button release];
    [_Ability6Button release];
    [_Ability7Button release];
    [_Ability8Button release];
    
    [_DescriptionField release];
    [_AbilityDescriptionField release];
    [_PlayButton release];
    [super dealloc];
}

- (void)UpdateAbilitiesAndPassives {    
    NSDictionary *abilityDict = [self.chosenHeroDictionary objectForKey:@"abilities"];
    NSArray *allKeys = [abilityDict allKeys];
    
    NSLog(@"%@", allKeys);
    
    [self.Ability1Button setImage:[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:0]] valueForKey:@"image"]]
                         forState:UIControlStateNormal];
    [self.Ability2Button setImage:[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:1]] valueForKey:@"image"]]
                         forState:UIControlStateNormal];
    [self.Ability3Button setImage:[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:2]] valueForKey:@"image"]]
                         forState:UIControlStateNormal];
    [self.Ability4Button setImage:[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:3]] valueForKey:@"image"]]
                         forState:UIControlStateNormal];
    [self.Ability5Button setImage:[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:4]] valueForKey:@"image"]]
                         forState:UIControlStateNormal];
    [self.Ability6Button setImage:[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:5]] valueForKey:@"image"]]
                         forState:UIControlStateNormal];
    [self.Ability7Button setImage:[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:6]] valueForKey:@"image"]]
                         forState:UIControlStateNormal];
    
    NSLog(@"value button 8: %@", [abilityDict objectForKey:[allKeys objectAtIndex:7]]);
    [self.Ability8Button setImage:[UIImage imageNamed:[[abilityDict objectForKey:[allKeys objectAtIndex:7]] valueForKey:@"image"]]
                         forState:UIControlStateNormal];
}

- (void)alertView:(COHAlertViewController *)alert wasDismissedWithButtonIndex:(NSInteger)buttonIndex
{
    if (alert.tag == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (alert.tag == 2)
    {
        if (buttonIndex == 2)
        {
            Hero *selectedHero = [Hero new];
            [selectedHero setHeroName:self.chosenHero];
            
            NSArray *keys = [self.chosenAbilities allKeys];
            [selectedHero setAbilityOne:[keys objectAtIndex:0]];
            [selectedHero setAbilityTwo:[keys objectAtIndex:1]];
            [selectedHero setAbilityThree:[keys objectAtIndex:2]];
            [selectedHero setAbilityFour:[keys objectAtIndex:3]];
            
            GCTurnBasedMatchHelper *helper = [GCTurnBasedMatchHelper sharedInstance];
            Player *localPlayer = [helper playerForLocalPlayer];
            
            NSInteger indexForPlayer = ([[helper currentPlayers] indexOfObject:localPlayer])+1;
            NSInteger positionX = 5;
            
            UnitData *warrior = [[UnitData alloc] initWithType:WARRIOR name:@"Warrior" tag:(100*indexForPlayer) andLocation:CGPointMake(positionX, 14)];
            
            UnitData *mage = [[UnitData alloc] initWithType:MAGE name:@"Mage" tag:((100*indexForPlayer)+1) andLocation:CGPointMake((positionX+1), 14)];
            
            UnitData *ranger = [[UnitData alloc] initWithType:RANGER name:@"Ranger" tag:((100*indexForPlayer)+2) andLocation:CGPointMake((positionX+2), 14)];
            
            UnitData *priest = [[UnitData alloc] initWithType:PRIEST name:@"Priest" tag:((100*indexForPlayer)+3) andLocation:CGPointMake((positionX+3), 14)];
            
            UnitData *shifter = [[UnitData alloc] initWithType:SHAPESHIFTER name:@"Shapeshifter" tag:((100*indexForPlayer)+4) andLocation:CGPointMake((positionX+4), 14)];
            
            [localPlayer setHero:selectedHero];
            [localPlayer setUnitData:[NSMutableArray arrayWithObjects:warrior, mage, ranger, priest, shifter, nil]];
            [helper endTurn:nil];
        }
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
