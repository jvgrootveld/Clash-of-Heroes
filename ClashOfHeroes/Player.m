//
//  Player.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 09-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "Player.h"
#import "Unit.h"
#import "UnitData.h"
#import "Hero.h"

@implementation Player

@synthesize hero = _hero, units = _units, gameCenterInfo = _gameCenterInfo, unitData = _unitData;

- (id)initForGKPlayer:(GKPlayer *)player
{
    if (self = [super init])
    {        
        self.hero = nil;
        self.units = [NSMutableArray array];
        self.unitData = [NSArray array];
        self.gameCenterInfo = player;
    }
    
    return self;
}

- (void)addUnit:(Unit *)unit
{
    [_units addObject:unit];
}

- (Unit *)unitForTag:(NSInteger)tag
{
    Unit *returnUnit = nil;
    
    for(Unit *unit in _units)
    {
        if(unit.tag == tag)
        {
            returnUnit = unit;
            break;
        }
    }
    
    return returnUnit;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *playerDict = [NSMutableDictionary dictionary];
    
    [playerDict setValue:[self.hero toDictionary] forKey:@"hero"];
    
    if (self.units.count != 0) //Check for unit objects as they only get set on the Game View, not hero selection
    {
        for (Unit *unit in self.units)
        {
            [playerDict setValue:[unit toDictionary] forKey:unit.name];
        }
    }
    else
    {
        for (UnitData *unitData in self.unitData)
        {
            [playerDict setValue:[unitData toDictionary] forKey:unitData.unitType];
        }
    }
    
    return playerDict;
}

@end
