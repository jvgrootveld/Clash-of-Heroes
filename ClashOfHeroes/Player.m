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

@synthesize hero = _hero, units = _units, gameCenterInfo = _gameCenterInfo, unitData = _unitData, turnNumber = _turnNumber;

- (id)initForGKPlayer:(GKPlayer *)player
{
    if (self = [super init])
    {        
        self.hero = nil;
        self.units = [NSMutableArray new];
        self.unitData = [NSArray new];
        self.gameCenterInfo = player;
        self.turnNumber = 0;
    }
    
    return self;
}

- (void)resetUnits
{
    self.units = [NSMutableArray new];
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
    BOOL revert = ((self == [[GCTurnBasedMatchHelper sharedInstance] playerForEnemyPlayer]) && [[GCTurnBasedMatchHelper sharedInstance] playerForLocalPlayer].turnNumber > 1);
    
    [playerDict setValue:[NSNumber numberWithInteger:self.turnNumber] forKey:@"turnNumber"];
    [playerDict setValue:[self.hero toDictionary] forKey:@"hero"];
    
    if (self.units.count > 0) //Check for unit objects as they only get set on the Game View, not hero selection
    {        
        for (Unit *unit in self.units)
        {
            self.unitData = [NSArray new];
            
            if (revert) unit.location = CGPointMake(abs(unit.location.x-14), abs(unit.location.y-14));
            
            UnitData *unitData = [[UnitData alloc] initWithName:unit.name tag:unit.tag andLocation:unit.location];
            [unitData setCurrentHealth:unit.healthPoints];
            [playerDict setValue:[unitData toDictionary] forKey:unitData.unitName];
        }
    }
    else
    {
        for (UnitData *unitData in self.unitData)
        {
            if (revert) unitData.location = CGPointMake(abs(unitData.location.x-14), abs(unitData.location.y-14));
            
            [playerDict setValue:[unitData toDictionary] forKey:unitData.unitName];
        }
    }
    
    return playerDict;
}

@end
