//
//  Unit.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "Unit.h"
#import "NoUpgrade.h"
#import <GameKit/GameKit.h>

@interface Unit(Local)
- (NSString *)directionToString:(NSInteger)directionValue;
@end

@implementation Unit

@synthesize upgrade = _upgrade, player = _player, moveDirection = _moveDirection, attackDirection = _attackDirection, canAttackTroughAir = _canAttackTroughAir;

- (id)initWithName:(NSString *)name player:(GKPlayer *)player andBaseStatsPhysicalAttackPower:(NSInteger)physicalAttackPower magicalAttackPower:(NSInteger)magicalAttackPower physicalDefense:(NSInteger)physicalDefense magicalDefense:(NSInteger)magicalDefense healthPoints:(NSInteger)healthPoints range:(NSInteger)range movement:(NSInteger)movement
{
    self = [super init];
    if (self) 
    {
        _name = name;
        _player = player;
        _upgrade = [NoUpgrade new];
        _basePhysicalAttackPower = physicalAttackPower;
        _baseMagicalAttackPower = magicalAttackPower;
        _basePhysicalDefense = physicalDefense;
        _baseMagicalDefense = magicalDefense;
        _baseHealthPoints = healthPoints;
        _baseRange = range;
        _baseMovement = movement;
        _canAttackTroughAir = NO;
        _recievedDamage = 0;
        [self setCode:@"?"];
    }
    
    return self;
}

- (NSInteger)physicalAttackPower
{
    return _basePhysicalAttackPower + [_upgrade physicalAttackPower];
}

- (NSInteger)magicalAttackPower
{
    return _baseMagicalAttackPower + [_upgrade magicalAttackPower];
}

- (NSInteger)physicalDefense
{
    return _basePhysicalDefense + [_upgrade physicalDefense];
}

- (NSInteger)magicalDefense
{
    return _baseMagicalDefense + [_upgrade magicalDefense];
}

- (NSInteger)healthPoints
{
    return (_baseHealthPoints + [_upgrade healthPoints]) - _recievedDamage;
}

- (NSInteger)range
{
    return _baseRange + [_upgrade range];
}

- (NSInteger)movement
{
    return _baseMovement + [_upgrade movement];
}

- (void)setCode:(NSString *)code
{
    _code = code;
}

- (BOOL)belongsToPlayer:(GKPlayer *)player
{
    return _player.playerID == player.playerID;
}

- (BOOL)containsDirection:(Direction)direction InDirection:(Direction)directionList
{
    NSInteger directionValue = directionList;
    
    if(directionValue > 0)
    {
        for(int i=128; i > 0; i/=2)
        {
            if(directionValue >= i)
            {
                if(direction == i) return YES;
                directionValue -= i;
            }
        }
    }
    
    return NO;
}

- (BOOL)canMoveInDirection:(Direction)direction
{
    return [self containsDirection:direction InDirection:self.moveDirection];
}

- (BOOL)canAttackInDirection:(Direction)direction
{
    return [self containsDirection:direction InDirection:self.attackDirection];
}

#pragma mark - Attacking methods

- (BOOL)recieveDamage:(NSInteger)damage
{
    _recievedDamage += damage;
    
    NSLog(@"%@ recieved %d damage, %d health remaining.", _name, damage, [self healthPoints]);
    if ([self healthPoints] <= 0) return YES;
    
    return NO;
}

- (void)reduceDamage:(NSInteger)damage
{
    _recievedDamage -= damage;
    
    NSLog(@"added %d health to %@, %d health remaining.", damage, _name, ([self healthPoints] - _recievedDamage));
}

- (NSString *)printCode
{
    return [NSString stringWithFormat:@"%@(%d)", _code, _player.playerID];
}

- (NSString *)directionToString:(NSInteger)directionValue
{
    NSString *output = @"";
    
    if(directionValue == 0)
        output = @"None, ";
    else
    {
        if(directionValue >= 128)
        {
            output = [output stringByAppendingString:@"BOTTOMRIGHT, "];
            directionValue -= 128;
        }
        if(directionValue >= 64)
        {
            output = [output stringByAppendingString:@"BOTTOMLEFT, "];
            directionValue -= 64;
        }
        if(directionValue >= 32)
        {
            output = [output stringByAppendingString:@"TOPRIGHT, "];
            directionValue -= 32;
        }
        if(directionValue >= 16)
        {
            output = [output stringByAppendingString:@"TOPLEFT, "];
            directionValue -= 16;
        }
        if(directionValue >= 8)
        {
            output = [output stringByAppendingString:@"RIGHT, "];
            directionValue -= 8;
        }
        if(directionValue >= 4)
        {
            output = [output stringByAppendingString:@"LEFT, "];
            directionValue -= 4;
        }
        if(directionValue >= 2)
        {
            output = [output stringByAppendingString:@"BOTTOM, "];
            directionValue -= 2;
        }
        if(directionValue >= 1)
        {
            output = [output stringByAppendingString:@"TOP, "];
            directionValue -= 1;
        }
    }
    
    output = [output substringToIndex:output.length-2]; //for the last 'comma space'
    
    return output;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nPiece: %@ \n\tPlayer: %@ \n\tGear: \t%@ \n\tP-atk: \t%d \n\tM-atk: \t%d \n\tP-def: \t%d \n\tM-def: \t%d \n\tHp: \t%d \n\tRange: \t%d \n\tMove: \t%d \n\tMove direction: %@ \n\tAttack direction: %@", _name, _player.alias, [_upgrade listOfUpgrades], [self physicalAttackPower], [self magicalAttackPower], [self physicalDefense], [self magicalDefense], [self healthPoints], [self range], [self movement], [self directionToString:_moveDirection], [self directionToString:_attackDirection]];
}

@end
