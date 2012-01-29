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

#define kPlayer @"CDPlayer"
#define kStats @"CDStats"

@interface StatsController()
+ (NSManagedObjectContext *)managedObjectContext;
+ (NSArray *)dataFromEntity:(NSString *)entityName;
+ (NSArray *)dataFromEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate;
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
        [testStats setGamesPlayedEldurin:[NSNumber numberWithInt:addGamesPlayed + testStats.gamesPlayedEldurin.integerValue]];
        
        NSError *error;
        
        if (![[self managedObjectContext] save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        
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
       [testStats setGamesPlayedGarrick:[NSNumber numberWithInt:addGamesPlayed + testStats.gamesPlayedGarrick.integerValue]];
        
        NSError *error;
        
        if (![[self managedObjectContext] save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        
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
        [testStats setGamesPlayerGalen:[NSNumber numberWithInt:addGamesPlayed + testStats.gamesPlayerGalen.integerValue]];
        
        NSError *error;
        
        if (![[self managedObjectContext] save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        
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
        [testStats setTotalDamageDealt:[NSNumber numberWithInt:addGamesPlayed + testStats.totalDamageDealt.integerValue]];
        
        NSError *error;
        
        if (![[self managedObjectContext] save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        
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
        [testStats setTotalDamageTaken:[NSNumber numberWithInt:addGamesPlayed + testStats.totalDamageTaken.integerValue]];
        
        NSError *error;
        
        if (![[self managedObjectContext] save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        
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
        [testStats setTotalMetersMoved:[NSNumber numberWithInt:addGamesPlayed + testStats.totalMetersMoved.integerValue]];
        
        NSError *error;
        
        if (![[self managedObjectContext] save:&error]) 
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

@end
