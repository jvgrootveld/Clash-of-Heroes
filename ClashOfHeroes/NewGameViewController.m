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
    
    // Default hero inladen
    self.chosenHero = @"Garrick";
    self.chosenHeroDictionary = [_heroes objectForKey:@"Garrick"];
    
    self.chosenAbilities = [NSMutableDictionary dictionary];
    
    // inladen van de plist: HeroDescriptions
    _heroes = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HeroDescriptions" ofType:@"plist"]];
    
    [self UpdateAbilitiesAndPassives:@"Garrick"];
    [self.DescriptionField setText:@"Garrick of the Four Swords \nGarrick is a notorious warrior known for fighting with four swords. His abilities excel in either the protection allies, or devastating melee attacks."];
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
    [self UpdateAbilitiesAndPassives:@"Galen"];
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
    [self UpdateAbilitiesAndPassives:@"Eldurin"];
    [self.AbilityDescriptionField setText:@""];
    
    [self resetAbilitiesAndPassive];
    
    [self.GalenButton setImage:[UIImage imageNamed:@"hero_galen_gray.png"] forState:UIControlStateNormal];
    [self.EldurinButton setImage:[UIImage imageNamed:@"hero_eldurin.png"] forState:UIControlStateNormal];
    [self.GarrickButton setImage:[UIImage imageNamed:@"hero_garrick_gray.png"] forState:UIControlStateNormal];  
    
}

#pragma validateAndSelectAbility

- (void)validateAndSelectAbility:(NSString *)ability andButtonByTag:(NSInteger) tag {

    if (_abilityCounter <= 3 && (![self.chosenAbilities objectForKey:ability]) ) {

        NSLog(@"Tag#: %d", tag);
        
        [self.chosenAbilities setObject:ability forKey:ability];

        UIButton * button = (UIButton *)[self.view viewWithTag:tag];
        
        [button setImage:[UIImage imageNamed:[[ability lowercaseString] stringByAppendingString:@".png"]] forState:UIControlStateNormal];
        
        _abilityCounter++;
        
    }  else if ([self.chosenAbilities objectForKey:ability]) {

        [self.chosenAbilities removeObjectForKey:ability];
        
        UIButton * button = (UIButton *)[self.view viewWithTag:tag];        
        
        [button setImage:[UIImage imageNamed:[[ability lowercaseString] stringByAppendingString:@"_gray.png"]] forState:UIControlStateNormal];
        
        _abilityCounter--;
        
    } else {
                NSLog(@"Teveel gekozen!");
    }
    
}

- (void)resetAbilitiesAndPassive {

    self.chosenAbilities = [NSMutableDictionary dictionary];
    self.abilityCounter = 0;
    
    if ( [_chosenHero isEqualToString:@"Garrick"] ) {
        
        [self.Ability1Button setImage:[UIImage imageNamed:@"charge_gray.png"] forState:UIControlStateNormal];
        [self.Ability2Button setImage:[UIImage imageNamed:@"disarm_gray.png"] forState:UIControlStateNormal];
        [self.Ability3Button setImage:[UIImage imageNamed:@"quadra-strike_gray.png"] forState:UIControlStateNormal];
        [self.Ability4Button setImage:[UIImage imageNamed:@"hurricane_gray.png"] forState:UIControlStateNormal];
        [self.Ability5Button setImage:[UIImage imageNamed:@"taunt_gray.png"] forState:UIControlStateNormal];
        [self.Ability6Button setImage:[UIImage imageNamed:@"sword-wall_gray.png"] forState:UIControlStateNormal];
        [self.Ability7Button setImage:[UIImage imageNamed:@"headbash_gray.png"] forState:UIControlStateNormal];
        [self.Ability8Button setImage:[UIImage imageNamed:@"battlecry_gray.png"] forState:UIControlStateNormal];
        
    } else if ( [_chosenHero isEqualToString:@"Galen"] ) {
        
        [self.Ability1Button setImage:[UIImage imageNamed:@"fireball_gray.png"] forState:UIControlStateNormal];
        [self.Ability2Button setImage:[UIImage imageNamed:@"thunder_gray.png"] forState:UIControlStateNormal];
        [self.Ability3Button setImage:[UIImage imageNamed:@"freeze_gray.png"] forState:UIControlStateNormal];
        [self.Ability4Button setImage:[UIImage imageNamed:@"ice shield_gray.png"] forState:UIControlStateNormal];
        [self.Ability5Button setImage:[UIImage imageNamed:@"blast_gray.png"] forState:UIControlStateNormal];
        [self.Ability6Button setImage:[UIImage imageNamed:@"slow_gray.png"] forState:UIControlStateNormal];
        [self.Ability7Button setImage:[UIImage imageNamed:@"haste_gray.png"] forState:UIControlStateNormal];
        [self.Ability8Button setImage:[UIImage imageNamed:@"missiles_gray.png"] forState:UIControlStateNormal];
        
    } else {

        [self.Ability1Button setImage:[UIImage imageNamed:@"heal_gray.png"] forState:UIControlStateNormal];
        [self.Ability2Button setImage:[UIImage imageNamed:@"greater heal_gray.png"] forState:UIControlStateNormal];
        [self.Ability3Button setImage:[UIImage imageNamed:@"endurance_gray.png"] forState:UIControlStateNormal];
        [self.Ability4Button setImage:[UIImage imageNamed:@"radiance_gray.png"] forState:UIControlStateNormal];
        [self.Ability5Button setImage:[UIImage imageNamed:@"flay_gray.png"] forState:UIControlStateNormal];
        [self.Ability6Button setImage:[UIImage imageNamed:@"flare_gray.png"] forState:UIControlStateNormal];
        [self.Ability7Button setImage:[UIImage imageNamed:@"pain_gray.png"] forState:UIControlStateNormal];
        [self.Ability8Button setImage:[UIImage imageNamed:@"siphon_gray.png"] forState:UIControlStateNormal];
        
    }
    
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

- (IBAction)Ability1Action:(id)sender {
    
    if ( [_chosenHero isEqualToString:@"Garrick"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Charge"]];
        
        [self validateAndSelectAbility:@"Charge" andButtonByTag:1];
        
    } else if ( [_chosenHero isEqualToString:@"Galen"] ) {
                 
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Fireball"]];
        
        [self validateAndSelectAbility:@"Fireball" andButtonByTag:1];
        
    } else {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Heal"]];
        
        [self validateAndSelectAbility:@"Heal" andButtonByTag:1];
        
    }
    
}

- (IBAction)Ability2Action:(id)sender {

    if ( [_chosenHero isEqualToString:@"Garrick"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Disarm"]];
        
        [self validateAndSelectAbility:@"Disarm" andButtonByTag:2];
        
    } else if ( [_chosenHero isEqualToString:@"Galen"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Thunder"]];
        
        [self validateAndSelectAbility:@"Thunder" andButtonByTag:2];
        
    } else {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Greater Heal"]];
        
        [self validateAndSelectAbility:@"Greater Heal" andButtonByTag:2];
        
    }
    
}

- (IBAction)Ability3Action:(id)sender {
    
    if ( [_chosenHero isEqualToString:@"Garrick"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Quadra-strike"]];
        
        [self validateAndSelectAbility:@"Quadra-strike" andButtonByTag:3];
        
    } else if ( [_chosenHero isEqualToString:@"Galen"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Freeze"]];
        
        [self validateAndSelectAbility:@"Freeze" andButtonByTag:3];
        
    } else {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Endurance"]];
        
        [self validateAndSelectAbility:@"Endurance" andButtonByTag:3];
        
    }
    
}

- (IBAction)Ability4Action:(id)sender {
    
    if ( [_chosenHero isEqualToString:@"Garrick"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Hurricane"]];
        
        [self validateAndSelectAbility:@"Hurricane" andButtonByTag:4];
        
    } else if ( [_chosenHero isEqualToString:@"Galen"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Freeze"]];
        
        [self validateAndSelectAbility:@"Ice shield" andButtonByTag:4];
        
    } else {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Radiance"]];
        
        [self validateAndSelectAbility:@"Radiance" andButtonByTag:4];
        
    }
    
}

- (IBAction)Ability5Action:(id)sender {
    
    if ( [_chosenHero isEqualToString:@"Garrick"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Taunt"]];
        
        [self validateAndSelectAbility:@"Taunt" andButtonByTag:5];
        
    } else if ( [_chosenHero isEqualToString:@"Galen"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Blast"]];
        
        [self validateAndSelectAbility:@"Blast" andButtonByTag:5];
        
    } else {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Flay"]];
        
        [self validateAndSelectAbility:@"Flay" andButtonByTag:5];
        
    }
    
}

- (IBAction)Ability6Action:(id)sender {
    
    if ( [_chosenHero isEqualToString:@"Garrick"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Sword-wall"]];
        
        [self validateAndSelectAbility:@"Sword-wall" andButtonByTag:6];
        
    } else if ( [_chosenHero isEqualToString:@"Galen"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Slow"]];
        
        [self validateAndSelectAbility:@"Slow" andButtonByTag:6];
        
    } else {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Flare"]];
        
        [self validateAndSelectAbility:@"Flare" andButtonByTag:6];
        
    }
    
}

- (IBAction)Ability7Action:(id)sender {
    
    if ( [_chosenHero isEqualToString:@"Garrick"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Headbash"]];
        
        [self validateAndSelectAbility:@"Headbash" andButtonByTag:7];
        
    } else if ( [_chosenHero isEqualToString:@"Galen"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Haste"]];
        
        [self validateAndSelectAbility:@"Haste" andButtonByTag:7];
        
    } else {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Pain"]];
        
        [self validateAndSelectAbility:@"Pain" andButtonByTag:7];
        
    }
    
}

- (IBAction)Ability8Action:(id)sender {
    
    if ( [_chosenHero isEqualToString:@"Garrick"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Battlecry"]];
        
        [self validateAndSelectAbility:@"Battlecry" andButtonByTag:8];
        
    } else if ( [_chosenHero isEqualToString:@"Galen"] ) {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Missiles"]];
        
        [self validateAndSelectAbility:@"Missiles" andButtonByTag:8];
        
    } else {
        
        [self.AbilityDescriptionField setText:[_chosenHeroDictionary objectForKey:@"Siphon"]];
        
        [self validateAndSelectAbility:@"Siphon" andButtonByTag:8];
        
    }
    
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

- (void)UpdateAbilitiesAndPassives:(NSString *)sender {
    
    self.chosenHeroDictionary = [_heroes objectForKey:sender];
    
    if([sender isEqualToString:@"Garrick"]) {
        
        [self.Ability1Button setImage:[UIImage imageNamed:@"charge_gray.png"] forState:UIControlStateNormal];
        [self.Ability2Button setImage:[UIImage imageNamed:@"disarm_gray.png"] forState:UIControlStateNormal];
        [self.Ability3Button setImage:[UIImage imageNamed:@"quadra-strike_gray.png"] forState:UIControlStateNormal];
        [self.Ability4Button setImage:[UIImage imageNamed:@"hurricane_gray.png"] forState:UIControlStateNormal];
        [self.Ability5Button setImage:[UIImage imageNamed:@"taunt_gray.png"] forState:UIControlStateNormal];
        [self.Ability6Button setImage:[UIImage imageNamed:@"sword-wall_gray.png"] forState:UIControlStateNormal];
        [self.Ability7Button setImage:[UIImage imageNamed:@"headbash_gray.png"] forState:UIControlStateNormal];
        [self.Ability8Button setImage:[UIImage imageNamed:@"battlecry_gray.png"] forState:UIControlStateNormal];

    } else if([sender isEqualToString:@"Galen"]) {
        
        [self.Ability1Button setImage:[UIImage imageNamed:@"fireball_gray.png"] forState:UIControlStateNormal];
        [self.Ability2Button setImage:[UIImage imageNamed:@"thunder_gray.png"] forState:UIControlStateNormal];
        [self.Ability3Button setImage:[UIImage imageNamed:@"freeze_gray.png"] forState:UIControlStateNormal];
        [self.Ability4Button setImage:[UIImage imageNamed:@"ice shield_gray.png"] forState:UIControlStateNormal];
        [self.Ability5Button setImage:[UIImage imageNamed:@"blast_gray.png"] forState:UIControlStateNormal];
        [self.Ability6Button setImage:[UIImage imageNamed:@"slow_gray.png"] forState:UIControlStateNormal];
        [self.Ability7Button setImage:[UIImage imageNamed:@"haste_gray.png"] forState:UIControlStateNormal];
        [self.Ability8Button setImage:[UIImage imageNamed:@"missiles_gray.png"] forState:UIControlStateNormal];
        
    } else {
        
        [self.Ability1Button setImage:[UIImage imageNamed:@"heal_gray.png"] forState:UIControlStateNormal];
        [self.Ability2Button setImage:[UIImage imageNamed:@"greater heal_gray.png"] forState:UIControlStateNormal];
        [self.Ability3Button setImage:[UIImage imageNamed:@"endurance_gray.png"] forState:UIControlStateNormal];
        [self.Ability4Button setImage:[UIImage imageNamed:@"radiance_gray.png"] forState:UIControlStateNormal];
        [self.Ability5Button setImage:[UIImage imageNamed:@"flay_gray.png"] forState:UIControlStateNormal];
        [self.Ability6Button setImage:[UIImage imageNamed:@"flare_gray.png"] forState:UIControlStateNormal];
        [self.Ability7Button setImage:[UIImage imageNamed:@"pain_gray.png"] forState:UIControlStateNormal];
        [self.Ability8Button setImage:[UIImage imageNamed:@"siphon_gray.png"] forState:UIControlStateNormal];
        
    }
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
