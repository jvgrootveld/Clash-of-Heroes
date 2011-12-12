//
//  Upgrade.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "Upgrade.h"

@implementation Upgrade

@synthesize upgrade = _upgrade;

- (id)init
{
    self = [super init];
    if (self) 
    {
        _name = @"Upgrade";
        [self setUpgrade:nil];
        _physicalAttackPower = 0;
        _magicalAttackPower = 0;
        _physicalDefense = 0;
        _magicalDefense = 0;
        _healthPoints = 0;
        _range = 0;
        _movement = 0;
    }
    
    return self;
}

- (id)initWithUpgrade:(Upgrade *)upgrade
{
    self = [self init];
    if (self) 
    {
        [self setUpgrade:upgrade];
    }
    
    return self;
}

- (Upgrade *)upgrade
{
    return _upgrade;
}

- (NSString *)name
{
    return _name;
}

- (NSInteger)physicalAttackPower
{
    return _physicalAttackPower + ((_upgrade) ? [_upgrade physicalAttackPower] : 0);
}

- (NSInteger)magicalAttackPower
{
    return _magicalAttackPower + ((_upgrade) ? [_upgrade magicalAttackPower] : 0);
}

- (NSInteger)physicalDefense
{
    return _physicalDefense + ((_upgrade) ? [_upgrade physicalDefense] : 0);
}

- (NSInteger)magicalDefense
{
    return _magicalDefense + ((_upgrade) ? [_upgrade magicalDefense] : 0);
}

- (NSInteger)healthPoints
{
    return _healthPoints + ((_upgrade) ? [_upgrade healthPoints] : 0);
}

- (NSInteger)range
{
    return _range + ((_upgrade) ? [_upgrade range] : 0);
}

- (NSInteger)movement
{
    return _movement + ((_upgrade) ? [_upgrade movement] : 0);
}

- (NSString *)listOfUpgrades
{
    NSString *listOfUpgrades = _name;
    Upgrade *up = _upgrade; 
    
    while(up)
    {
        listOfUpgrades = [listOfUpgrades stringByAppendingFormat:@", %@", [up name]];
        up = [up upgrade];
    }
    
    return listOfUpgrades;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nUpgrades: %@ \n\tP-atk: %d \n\tM-atk: %d \n\tP-def: %d \n\tM-def: %d \n\tHp: %d \n\tRange: %d \n\tMove: %d", [self listOfUpgrades], [self physicalAttackPower], [self magicalAttackPower], [self physicalDefense], [self magicalDefense], [self healthPoints], [self range], [self movement]];
}

@end
