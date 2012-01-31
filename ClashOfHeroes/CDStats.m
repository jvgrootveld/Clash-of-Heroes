//
//  CDStats.m
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 1/29/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "CDStats.h"
#import "CDPlayer.h"


@implementation CDStats

@dynamic gamesPlayedEldurin;
@dynamic gamesPlayerGalen;
@dynamic gamesPlayedGarrick;
@dynamic totalMetersMoved;
@dynamic totalDamageDealt;
@dynamic totalDamageTaken;
@dynamic gamesWon;
@dynamic player;

- (NSInteger)totalGamesPlayed
{
    return (self.gamesPlayedEldurin.integerValue + 
            self.gamesPlayedGarrick.integerValue + 
            self.gamesPlayerGalen.integerValue);
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *printDictionairy = [NSMutableDictionary dictionary];
    
    [printDictionairy setValue:self.gamesPlayedEldurin forKey:@"gamesPlayedEldurin"];
    [printDictionairy setValue:self.gamesPlayerGalen forKey:@"gamesPlayerGalen"];
    [printDictionairy setValue:self.gamesPlayedGarrick forKey:@"gamesPlayedGarrick"];
    [printDictionairy setValue:self.totalMetersMoved forKey:@"totalMetersMoved"];
    [printDictionairy setValue:self.totalDamageDealt forKey:@"totalDamageDealt"];
    [printDictionairy setValue:self.totalDamageTaken forKey:@"totalDamageTaken"];
    [printDictionairy setValue:self.gamesWon forKey:@"gamesWon"];
    
    return printDictionairy;
}

- (NSString *)description
{
    return [[self toDictionary] description];
}

@end
