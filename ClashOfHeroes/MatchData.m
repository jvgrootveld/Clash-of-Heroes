//
//  MatchData.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 26-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <GameKit/GameKit.h>

#import "MatchData.h"
#import "Player.h"

@implementation MatchData

@synthesize playerOne = _playerOne, playerTwo = _playerTwo;

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *matchDict = [NSMutableDictionary dictionary];
    
    [matchDict setValue:[self.playerOne toDictionary] forKey:self.playerOne.gameCenterInfo.playerID];
    [matchDict setValue:[self.playerTwo toDictionary] forKey:self.playerTwo.gameCenterInfo.playerID];
    
    return matchDict;
}

@end
