//
//  GCTurnBasedMatchHelper.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 24-11-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "GCTurnBasedMatchHelper.h"
#import "MainMenuViewController.h"
#import "GameViewController.h"
#import "Player.h"
#import "Turn.h"
#import "MatchData.h"

#import "Hero.h"
#import "UnitData.h"

@interface GCTurnBasedMatchHelper()

- (BOOL)isGameCenterAvailable;
- (void)synchronizeMatchData:(NSDictionary *)matchData;

@end

@implementation GCTurnBasedMatchHelper

@synthesize gameCenterAvailable, currentMatch, mainMenu = _mainMenu, gameViewController = _gameViewController, currentPlayers = _currentPlayers;

static GCTurnBasedMatchHelper *sharedHelper = nil;

#pragma mark Initialization

- (id)init
{
    if ((self = [super init])) 
    {
        gameCenterAvailable = [self isGameCenterAvailable];
        
        if (gameCenterAvailable) 
        {
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            
            [nc addObserver:self 
                   selector:@selector(authenticationChanged) 
                       name:GKPlayerAuthenticationDidChangeNotificationName 
                     object:nil];
        }
    }
    
    return self;
}

#pragma mark - Authentication

- (void)authenticationChanged
{    
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) 
    {
        NSLog(@"Authentication changed: player authenticated.");
        [self.mainMenu.startButton setEnabled:YES];
        userAuthenticated = TRUE;           
    } 
    else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) 
    {
        NSLog(@"Authentication changed: player not authenticated");
        userAuthenticated = FALSE;
    }
}

+ (GCTurnBasedMatchHelper *)sharedInstance
{
    if (!sharedHelper) 
    {
        sharedHelper = [[GCTurnBasedMatchHelper alloc] init];
    }
    return sharedHelper;
}

- (BOOL)isGameCenterAvailable
{
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer     
                                           options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

#pragma mark User methods

- (void)authenticateLocalUser
{ 
    if (!gameCenterAvailable) return;
    
    NSLog(@"Authenticating local user...");
    
    if ([GKLocalPlayer localPlayer].authenticated == NO)
    {    
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];        
    } 
    else 
    {
        NSLog(@"Already authenticated!");
    }
}

#pragma mark - Match setup

- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewController:(UIViewController *)viewController
{
    if (!gameCenterAvailable) return;               
    
    presentingViewController = viewController;
    
    GKMatchRequest *request = [[GKMatchRequest alloc] init]; 
    request.minPlayers = minPlayers;     
    request.maxPlayers = maxPlayers;
    
    GKTurnBasedMatchmakerViewController *mmvc = [[GKTurnBasedMatchmakerViewController alloc] initWithMatchRequest:request];    
    mmvc.turnBasedMatchmakerDelegate = self;
    mmvc.showExistingMatches = YES;
    
    [presentingViewController presentModalViewController:mmvc animated:YES];
}

#pragma mark GKTurnBasedMatchmakerViewControllerDelegate

-(void)turnBasedMatchmakerViewController: (GKTurnBasedMatchmakerViewController *)viewController didFindMatch:(GKTurnBasedMatch *)match
{
    [presentingViewController dismissModalViewControllerAnimated:YES];
    
    //NSLog(@"Matchdata (%d bytes): %@", match.matchData.length, match.matchData);
    NSDictionary *matchData = [NSKeyedUnarchiver unarchiveObjectWithData:match.matchData];
    
    NSLog(@"MatchData %@", matchData);
    
    self.currentMatch = match;
    
    [self loadPlayerDataWithMatchData:matchData];
}

-(void)turnBasedMatchmakerViewControllerWasCancelled: (GKTurnBasedMatchmakerViewController *)viewController
{
    [presentingViewController dismissModalViewControllerAnimated:YES];
    NSLog(@"has cancelled");
}

-(void)turnBasedMatchmakerViewController: (GKTurnBasedMatchmakerViewController *)viewController didFailWithError:(NSError *)error
{
    [presentingViewController dismissModalViewControllerAnimated:YES];
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error finding match" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alert show];
    NSLog(@"Error finding match: %@", error.localizedDescription);
}

-(void)turnBasedMatchmakerViewController: (GKTurnBasedMatchmakerViewController *)viewController playerQuitForMatch:(GKTurnBasedMatch *)match
{
    NSUInteger currentIndex = 
    [match.participants indexOfObject:match.currentParticipant];
    GKTurnBasedParticipant *part;
    
    for (int i = 0; i < [match.participants count]; i++) {
        part = [match.participants objectAtIndex:
                (currentIndex + 1 + i) % match.participants.count];
        if (part.matchOutcome != GKTurnBasedMatchOutcomeQuit) {
            break;
        } 
    }
    NSLog(@"playerquitforMatch, %@, %@", 
          match, match.currentParticipant);
    [match participantQuitInTurnWithOutcome:
     GKTurnBasedMatchOutcomeQuit nextParticipant:part 
                                  matchData:match.matchData completionHandler:nil];
}

#pragma mark - Player data

- (void)loadPlayerDataWithMatchData:(NSDictionary *)dataDictionary
{
    NSMutableArray *identifiers = [NSMutableArray array];
    
    for (GKTurnBasedParticipant *participant in self.currentMatch.participants)
    {
        if(participant.playerID) [identifiers addObject:participant.playerID];
    }
    
    [GKPlayer loadPlayersForIdentifiers:identifiers withCompletionHandler:^(NSArray *players, NSError *error) 
    {
        if (error)
        {
            NSLog(@"Error: %@", error);
        }
        
        if (players)
        {
            _currentPlayers = [NSMutableArray new];
            
            for(GKPlayer *gkplayer in players)
            {
                Player *player = [[Player alloc] initForGKPlayer:gkplayer];
                NSLog(@"add player %@", player.gameCenterInfo.alias);
                [_currentPlayers addObject:player];
            }        
        }
        
        if (dataDictionary) [self synchronizeMatchData:dataDictionary];
             
        if(self.currentMatch.currentParticipant.lastTurnDate)
        {
            NSLog(@"Load game");
            [self.mainMenu presentGameView];
        }
        else
        {
            NSLog(@"new game");
            [self.mainMenu presentNewGameView];
        }
    }];
}

- (void)synchronizeMatchData:(NSDictionary *)matchData
{
    for (Player *player in self.currentPlayers)
    {
        NSDictionary *playerData = [matchData objectForKey:player.gameCenterInfo.playerID];
        [player setTurnNumber:[[player valueForKey:@"turnNumber"] integerValue]];
        
        if (playerData)
        {
            NSDictionary *heroDict = [playerData objectForKey:@"hero"];
            NSDictionary *warriorDict = [playerData objectForKey:@"Warrior"];
            NSDictionary *mageDict = [playerData objectForKey:@"Mage"];
            NSDictionary *rangerDict = [playerData objectForKey:@"Ranger"];
            NSDictionary *priestDict = [playerData objectForKey:@"Priest"];
            NSDictionary *shifterDict = [playerData objectForKey:@"Shapeshifter"];
            
            if (heroDict) 
            {
                Hero *heroUnit = [Hero new];
                
                [heroUnit setHeroName:[heroDict valueForKey:@"heroName"]];
                [heroUnit setCurrentHealth:[[heroDict valueForKey:@"health"] integerValue]];
                [heroUnit setAbilityOne:[heroDict valueForKey:@"abilityOne"]];
                [heroUnit setAbilityTwo:[heroDict valueForKey:@"abilityTwo"]];
                [heroUnit setAbilityThree:[heroDict valueForKey:@"abilityThree"]];
                [heroUnit setAbilityFour:[heroDict valueForKey:@"abilityFour"]];
                
                [player setHero:heroUnit];
            }
            
            NSMutableArray *unitArray = [NSMutableArray array];
            
            if (warriorDict)
            {                
                UnitData *warriorUnit = [[UnitData alloc] initWithType:WARRIOR
                                                                  name:@"Warrior"
                                                            tag:[[warriorDict valueForKey:@"tag"] integerValue]
                                                           andLocation:[[warriorDict valueForKey:@"location"] CGPointValue]];
                [unitArray addObject:warriorUnit];
            }
            
            if (mageDict)
            {
                UnitData *mageUnit = [[UnitData alloc] initWithType:MAGE
                                                               name:@"Mage"
                                                                   tag:[[mageDict valueForKey:@"tag"] integerValue]
                                                           andLocation:[[mageDict valueForKey:@"location"] CGPointValue]];
                
                [unitArray addObject:mageUnit];
            }
            
            if (rangerDict)
            {
                UnitData *rangerUnit = [[UnitData alloc] initWithType:RANGER
                                                                 name:@"Ranger"
                                                                   tag:[[rangerDict valueForKey:@"tag"] integerValue]
                                                           andLocation:[[rangerDict valueForKey:@"location"] CGPointValue]];
                
                [unitArray addObject:rangerUnit];
            }
            
            if (priestDict)
            {
                UnitData *priestUnit = [[UnitData alloc] initWithType:PRIEST
                                                                 name:@"Priest"
                                                                   tag:[[priestDict valueForKey:@"tag"] integerValue]
                                                          andLocation:[[priestDict valueForKey:@"location"] CGPointValue]];
                
                [unitArray addObject:priestUnit];
            }
            
            if (shifterDict)
            {
                UnitData *shifterUnit = [[UnitData alloc] initWithType:SHAPESHIFTER
                                                                  name:@"Shapeshifter"
                                                                   tag:[[shifterDict valueForKey:@"tag"] integerValue]
                                                           andLocation:[[shifterDict valueForKey:@"location"] CGPointValue]];
                
                [unitArray addObject:shifterUnit];
            }
            
            [player setUnitData:unitArray];      
        }
    }
}

#pragma mark - players
- (Player *)playerForLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    for(Player *player in _currentPlayers)
    {
        if([player.gameCenterInfo.playerID isEqualToString:localPlayer.playerID]) return player;
    }
    
    return nil;
}

- (Player *)playerForEnemyPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    for(Player *player in _currentPlayers)
    {
        if(![player.gameCenterInfo.playerID isEqualToString:localPlayer.playerID]) return player;
    }
    
    return nil;
}

- (BOOL)localPlayerIsCurrentParticipant
{
    return [self.playerForLocalPlayer.gameCenterInfo.playerID isEqualToString:self.currentMatch.currentParticipant.playerID];
}

#pragma mark - Turns

- (void)endTurn:(Turn *)turn
{   
    Player *localPlayer = [self playerForLocalPlayer];
    Player *enemyPlayer = [self playerForEnemyPlayer];
    
    localPlayer.turnNumber += 1;
    enemyPlayer.turnNumber += 1;
    
    MatchData *matchData = [MatchData new];
    [matchData setPlayerOne:[self playerForLocalPlayer]];
    [matchData setPlayerTwo:[self playerForEnemyPlayer]];    
    
    NSData *compressedData = [NSKeyedArchiver archivedDataWithRootObject:[matchData toDictionary]];
    
    NSLog(@"data size: %d bytes.", compressedData.length);
    
    NSUInteger currentIndex = [self.currentMatch.participants indexOfObject:self.currentMatch.currentParticipant];
    
    GKTurnBasedParticipant *nextParticipant;
    nextParticipant = [self.currentMatch.participants objectAtIndex:((currentIndex + 1) % [self.currentMatch.participants count ])];
    [currentMatch endTurnWithNextParticipant:nextParticipant matchData:compressedData completionHandler:^(NSError *error) {
                                       if (error) {
                                           NSLog(@"%@", error);
                                       }
                                   }];
}

@end
