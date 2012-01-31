//
//  StatsController.m
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 1/29/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "StatsController.h"
#import "CDPlayer.h"
#import "CDStats.h"
#import "AppDelegate.h"
#import "GameCenterManager.h"
#import "AppSpecificValues.h"

#define kPlayer @"CDPlayer"
#define kStats @"CDStats"

@interface StatsController()
//data
+ (NSManagedObjectContext *)managedObjectContext;
+ (NSArray *)dataFromEntity:(NSString *)entityName;
+ (NSArray *)dataFromEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate;

//achievement check
+ (void)submitAchievement:(NSString*)identifier percentComplete:(double)percentComplete;
+ (void)updateAchievementForGamesPlayedEldurin:(NSInteger)gamesPlayedEldurin;
+ (void)updateAchievementForGamesPlayedGarrick:(NSInteger)gamesPlayedGarrick;
+ (void)updateAchievementForGamesPlayedGalen:(NSInteger)gamesPlayedGalen;
+ (void)updateAchievementForTotalGamesPlayed:(NSInteger)totalGamesPlayed;
+ (void)updateAchievementForTotalDamageDealt:(NSInteger)totalDamageDealt;
+ (void)updateAchievementForTotalDamageTaken:(NSInteger)totalDamageTaken;
+ (void)updateAchievementForTotalMetersMoved:(NSInteger)totalMetersMoved;
+ (void)updateAchievementForGamesWon:(NSInteger)totalGamesWon;
@end

@implementation StatsController

#pragma mark - Local

+ (NSManagedObjectContext *)managedObjectContext
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [delegate managedObjectContext];
}

+ (NSArray *)dataFromEntity:(NSString *)entityName
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    //Fetch colletions from core data
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    
    return [context executeFetchRequest:fetchRequest error:&error];
}

+ (NSArray *)dataFromEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    //Fetch colletions from core data
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    
    NSArray *returnArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if(!returnArray) NSLog(@"error: %@", [error localizedDescription]);
    
    return returnArray;
}

#pragma mark - SET

+ (CDPlayer *)newPlayerAndStatsForPlayerWithGameCenterId:(NSString *)gameCenterId
{
    NSManagedObjectContext *context = [self managedObjectContext];

    if([self playerForGameCenterId:gameCenterId])
    {
        NSLog(@"Error new player: Player: %@ already excist", gameCenterId);
        return NO;
    }
    
    CDPlayer *newPlayer = [NSEntityDescription insertNewObjectForEntityForName:kPlayer inManagedObjectContext:context];
    [newPlayer setGameCenterId:gameCenterId];
    
    CDStats *newStats = [NSEntityDescription insertNewObjectForEntityForName:kStats inManagedObjectContext:context];
    [newStats setGamesPlayedEldurin:[NSNumber numberWithInt:0]];
    [newStats setGamesPlayedGarrick:[NSNumber numberWithInt:0]];
    [newStats setGamesPlayerGalen:[NSNumber numberWithInt:0]];
    [newStats setTotalDamageDealt:[NSNumber numberWithInt:0]];
    [newStats setTotalDamageTaken:[NSNumber numberWithInt:0]];
    [newStats setTotalMetersMoved:[NSNumber numberWithInt:0]];
    
    [newPlayer setStats:newStats];
    [newStats setPlayer:newPlayer];
    
    NSError *error;
    
    if (![context save:&error]) 
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return nil;
    }
    
    return [self playerForGameCenterId:gameCenterId];
}

#pragma mark - SET

+ (CDPlayer *)playerForGameCenterId:(NSString *)gameCenterId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"gameCenterId == %@", gameCenterId];
    NSArray *data = [self dataFromEntity:kPlayer withPredicate:predicate];
    
    if(data && [data count] > 0) return (CDPlayer *)[data objectAtIndex:0];
    
    return nil; //if this is is the case.. what happend?
}

#pragma mark - UPDATE

+ (BOOL)addGamesPlayedEldurin:(NSInteger)addGamesPlayed forPlayer:(NSString *)gameCenterId
{
    CDPlayer *testPlayer = [self playerForGameCenterId:gameCenterId];
    
    if(testPlayer)
    {   
        CDStats *testStats = (CDStats *)testPlayer.stats;
        
        NSInteger total = addGamesPlayed + testStats.gamesPlayedEldurin.integerValue;
        
        [testStats setGamesPlayedEldurin:[NSNumber numberWithInt:total]];
        
        NSError *error;
        
        if (![[self managedObjectContext] save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        
        //update achievement
        [self updateAchievementForGamesPlayedEldurin:total];
        [self updateAchievementForTotalGamesPlayed:total];
        
        return YES;
    }
    
    return NO;
}

+ (BOOL)addGamesPlayedGarrick:(NSInteger)addGamesPlayed forPlayer:(NSString *)gameCenterId
{
    CDPlayer *testPlayer = [self playerForGameCenterId:gameCenterId];
    
    if(testPlayer)
    {
        CDStats *testStats = (CDStats *)testPlayer.stats;
        
        NSInteger total = addGamesPlayed + testStats.gamesPlayedGarrick.integerValue;
        
       [testStats setGamesPlayedGarrick:[NSNumber numberWithInt:total]];
        
        NSError *error;
        
        if (![[self managedObjectContext] save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        
        //update achievement
        [self updateAchievementForGamesPlayedGarrick:total];
        [self updateAchievementForTotalGamesPlayed:total];
        
        return YES;
    }
    
    return NO;
}

+ (BOOL)addGamesPlayedGalen:(NSInteger)addGamesPlayed forPlayer:(NSString *)gameCenterId
{
    CDPlayer *testPlayer = [self playerForGameCenterId:gameCenterId];
    
    if(testPlayer)
    {
        CDStats *testStats = (CDStats *)testPlayer.stats;
        
        NSInteger total = addGamesPlayed + testStats.gamesPlayerGalen.integerValue;
        
        [testStats setGamesPlayerGalen:[NSNumber numberWithInt:total]];
        
        NSError *error;
        
        if (![[self managedObjectContext] save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        
        //update achievement
        [self updateAchievementForGamesPlayedGalen:total];
        [self updateAchievementForTotalGamesPlayed:total];
        
        return YES;
    }
    
    return NO;
}

+ (BOOL)addTotalDamageDealt:(NSInteger)addGamesPlayed forPlayer:(NSString *)gameCenterId
{
    CDPlayer *testPlayer = [self playerForGameCenterId:gameCenterId];
    
    if(testPlayer)
    {
        CDStats *testStats = (CDStats *)testPlayer.stats;
        
        NSInteger total = addGamesPlayed + testStats.totalDamageDealt.integerValue;
        
        [testStats setTotalDamageDealt:[NSNumber numberWithInt:total]];
        
        NSError *error;
        
        if (![[self managedObjectContext] save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        
        //update achievement
        [self updateAchievementForTotalDamageDealt:total];
        
        return YES;
    }
    
    return NO;
}

+ (BOOL)addTotalDamageTaken:(NSInteger)addGamesPlayed forPlayer:(NSString *)gameCenterId
{
    CDPlayer *testPlayer = [self playerForGameCenterId:gameCenterId];
    
    if(testPlayer)
    {
        CDStats *testStats = (CDStats *)testPlayer.stats;
        
        NSInteger total = addGamesPlayed + testStats.totalDamageTaken.integerValue;
        
        [testStats setTotalDamageTaken:[NSNumber numberWithInt:total]];
        
        NSError *error;
        
        if (![[self managedObjectContext] save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        
        //update achievement
        [self updateAchievementForTotalDamageTaken:total];
        
        return YES;
    }
    
    return NO;
}

+ (BOOL)addTotalMetersMoved:(NSInteger)addGamesPlayed forPlayer:(NSString *)gameCenterId
{
    CDPlayer *testPlayer = [self playerForGameCenterId:gameCenterId];
    
    if(testPlayer)
    {
        CDStats *testStats = (CDStats *)testPlayer.stats;
        
        NSInteger total = addGamesPlayed + testStats.totalMetersMoved.integerValue;
        
        [testStats setTotalMetersMoved:[NSNumber numberWithInt:total]];
        
        NSError *error;
        
        if (![[self managedObjectContext] save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        
        //update achievement
        [self updateAchievementForTotalMetersMoved:total];
        
        return YES;
    }
    
    return NO;
}

+ (BOOL)addGamesWon:(NSInteger)gamesWon forPlayer:(NSString *)gameCenterId
{
    CDPlayer *testPlayer = [self playerForGameCenterId:gameCenterId];
    
    if(testPlayer)
    {
        CDStats *testStats = (CDStats *)testPlayer.stats;
        
        NSInteger total = gamesWon + testStats.gamesWon.integerValue;
        
        [testStats setGamesWon:[NSNumber numberWithInt:total]];
        
        NSError *error;
        
        if (![[self managedObjectContext] save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        
        //update achievement
        [self updateAchievementForGamesWon:total];
        
        return YES;
    }
    
    return NO;
}

#pragma mark - Update Achievements

+ (void)submitAchievement:(NSString*)identifier percentComplete:(double)percentComplete
{
    if(identifier)
    {
        GameCenterManager *gameCenterManager = [GameCenterManager sharedInstance];
        
        [gameCenterManager submitAchievement:identifier percentComplete:percentComplete];
    }
}

+ (void)updateAchievementForGamesPlayedEldurin:(NSInteger)gamesPlayedEldurin
{
    NSString *identifier;
    double percentComplete = 0;
    
    if(gamesPlayedEldurin > 0)
    {
        identifier = kAchievement5PlayedEldurin;
        
        if(gamesPlayedEldurin < 5)
        {
            percentComplete = (100/5) * gamesPlayedEldurin;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement10PlayedEldurin;
        
        if(gamesPlayedEldurin < 10)
        {
            percentComplete = (100/10) * gamesPlayedEldurin;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
    }
}

+ (void)updateAchievementForGamesPlayedGarrick:(NSInteger)gamesPlayedGarrick
{   
    NSString *identifier;
    double percentComplete = 0;
    
    if(gamesPlayedGarrick > 0)
    {
        identifier = kAchievement5PlayedGarrick;
        
        if(gamesPlayedGarrick < 5)
        {
            percentComplete = (100/5) * gamesPlayedGarrick;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement10PlayedGarrick;
        
        if(gamesPlayedGarrick < 10)
        {
            percentComplete = (100/10) * gamesPlayedGarrick;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
    }
}

+ (void)updateAchievementForGamesPlayedGalen:(NSInteger)gamesPlayedGalen
{
    NSString *identifier;
    double percentComplete = 0;
    
    if(gamesPlayedGalen > 0)
    {
        identifier = kAchievement5PlayedGalen;
        
        if(gamesPlayedGalen < 5)
        {
            percentComplete = (100/5) * gamesPlayedGalen;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement10PlayedGalen;
        
        if(gamesPlayedGalen < 10)
        {
            percentComplete = (100/10) * gamesPlayedGalen;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
    }
}

+ (void)updateAchievementForTotalGamesPlayed:(NSInteger)totalGamesPlayed
{
    NSString *identifier;
    double percentComplete = 0;
    
    if(totalGamesPlayed > 0)
    {
        identifier = kAchievement5GamesPlayed;
        
        if(totalGamesPlayed < 5)
        {
            percentComplete = (100/5) * totalGamesPlayed;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement10GamesPlayed;
        
        if(totalGamesPlayed < 10)
        {
            percentComplete = (100/10) * totalGamesPlayed;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement25GamesPlayed;
        
        if(totalGamesPlayed < 25)
        {
            percentComplete = (100/25) * totalGamesPlayed;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement50GamesPlayed;
        
        if(totalGamesPlayed < 50)
        {
            percentComplete = (100/50) * totalGamesPlayed;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement100GamesPlayed;
        
        if(totalGamesPlayed < 100)
        {   
            percentComplete = (100/100) * totalGamesPlayed;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
    }
}

+ (void)updateAchievementForTotalDamageDealt:(NSInteger)totalDamageDealt
{
    NSString *identifier;
    double percentComplete = 0;
    
    if(totalDamageDealt > 0)
    {
        identifier = kAchievement10DamageDealt;
        
        if(totalDamageDealt < 10)
        {
            percentComplete = (100/10) * totalDamageDealt;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement100DamageDealt;
        
        if(totalDamageDealt < 100)
        {
            percentComplete = (100/100) * totalDamageDealt;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement1000DamageDealt;
        
        if(totalDamageDealt < 1000)
        {
            percentComplete = (100/1000) * totalDamageDealt;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement10000DamageDealt;
        
        if(totalDamageDealt < 10000)
        {
            percentComplete = (100/10000) * totalDamageDealt;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
    }
}

+ (void)updateAchievementForTotalDamageTaken:(NSInteger)totalDamageTaken
{
    NSString *identifier;
    double percentComplete = 0;
    
    if(totalDamageTaken > 0)
    {
        identifier = kAchievement10DamageTaken;
        
        if(totalDamageTaken < 10)
        {
            percentComplete = (100/10) * totalDamageTaken;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement100DamageTaken;
        
        if(totalDamageTaken < 100)
        {
            percentComplete = (100/100) * totalDamageTaken;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement1000DamageTaken;
        
        if(totalDamageTaken < 1000)
        {
            percentComplete = (100/1000) * totalDamageTaken;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement10000DamageTaken;
        
        if(totalDamageTaken < 10000)
        {
            percentComplete = (100/10000) * totalDamageTaken;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
    }
}

+ (void)updateAchievementForTotalMetersMoved:(NSInteger)totalMetersMoved
{
    NSString *identifier;
    double percentComplete = 0;
    
    if(totalMetersMoved > 0)
    {
        identifier = kAchievement10MetersWalked;
        
        if(totalMetersMoved <= 10)
        {
            percentComplete = (100/10) * totalMetersMoved;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement500MetersWalked;
        
        if(totalMetersMoved <= 500)
        {
            percentComplete = (100/500) * totalMetersMoved;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement1000MetersWalked;
        
        if(totalMetersMoved <= 1000)
        {
            percentComplete = (100/1000) * totalMetersMoved;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
    }
}

+ (void)updateAchievementForGamesWon:(NSInteger)totalGamesWon
{
    GameCenterManager *gameCenterManager = [GameCenterManager sharedInstance];
    
    NSString *identifier;
    double percentComplete = 0;
    
    if(totalGamesWon > 0)
    {
        identifier = kAchievement10GamesWon;
        
        if(totalGamesWon <= 10)
        {
            percentComplete = (100/10) * totalGamesWon;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement50GamesWon;
        
        if(totalGamesWon <= 50)
        {
            percentComplete = (100/50) * totalGamesWon;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        identifier = kAchievement100GamesWon;
        
        if(totalGamesWon <= 100)
        {
            percentComplete = (100/100) * totalGamesWon;
        }
        else
        {
            percentComplete = 100;
        }
        
        [self submitAchievement:identifier percentComplete:percentComplete];
        
        //leaderboard
        [gameCenterManager reportScore:totalGamesWon forCategory:kLeaderboardID];
    }
    
    
}

@end
