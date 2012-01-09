//
//  Player.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 09-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "Player.h"
#import "Warrior.h"
#import "Mage.h"
#import "Ranger.h"
#import "Priest.h"
#import "Shapeshifter.h"

@implementation Player

@synthesize hero = _hero, units = _units, gameCenterInfo = _gameCenterInfo;

- (id)initForGKPlayer:(GKPlayer *)player
{
    if (self = [super init])
    {        
        self.units = [NSMutableArray array];
        self.gameCenterInfo = player;
    }
    
    return self;
}

@end
