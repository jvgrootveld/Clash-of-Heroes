//
//  Unit.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "Unit.h"
#import "NoUpgrade.h"
#import "Player.h"
#import "GameLayer.h"
#import <GameKit/GameKit.h>

@interface Unit(Local)
- (NSString *)directionToString:(NSInteger)directionValue;
@end

@implementation Unit

@synthesize name = _name, upgrade = _upgrade, player = _player, moveDirection = _moveDirection, attackDirection = _attackDirection, canAttackTroughAir = _canAttackTroughAir;

- (id)initWithName:(NSString *)name player:(Player *)player andBaseStatsPhysicalAttackPower:(NSInteger)physicalAttackPower magicalAttackPower:(NSInteger)magicalAttackPower physicalDefense:(NSInteger)physicalDefense magicalDefense:(NSInteger)magicalDefense healthPoints:(NSInteger)healthPoints range:(NSInteger)range movement:(NSInteger)movement tag:(NSInteger)tag file:(NSString*)filename rect:(CGRect)rect
{
    if (self = [super initWithFile:filename rect:rect]) 
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
        
        [player addUnit:self];
        [self setTag:tag];
        [self setAnchorPoint:ccp(0.5f, 0.0f)]; //if problem, move to individual classes like Warrior, Mage, etc.
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

- (BOOL)belongsToPlayer:(Player *)player
{
    return _player == player;
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

- (NSMutableArray *)pointsWhichCanBeMovedAtWithTouchPositionPoint:(CGPoint)positionPoint inLayer:(GameLayer *)layer
{
    NSMutableArray *returnArray = [NSMutableArray new];
    
    const int mapBoundaryX = [layer mapBoundaryX];
    const int mapBoundaryY = [layer mapBoundaryY];
    const int positionX = positionPoint.x;
    const int positionY = positionPoint.y;
    int newY, newX;
    
    int i = 0;
    
    NSInteger _range = self.range;
    
    if([self containsDirection:FORWARD InDirection:self.moveDirection])
    {
         for(i = 1; i <= _range; i++)
         {
             newY = positionY - i;
             
             if(newY >= 0) [returnArray addObject:[NSValue valueWithCGPoint:CGPointMake(positionX, newY)]];
             else break;
         }
        
    }
    
    if([self containsDirection:BACKWARD InDirection:self.moveDirection])
    {
        for(i = 1; i <= _range; i++)
        {
            newY = positionY + i;
            
            if(newY <= mapBoundaryY) [returnArray addObject:[NSValue valueWithCGPoint:CGPointMake(positionX, newY)]];
            else break;
        }
    }
    
    if([self containsDirection:LEFT InDirection:self.moveDirection])
    {
        for(i = 1; i <= _range; i++)
        {
            newX = positionX - i;
            
            if(newX >= 0) [returnArray addObject:[NSValue valueWithCGPoint:CGPointMake(newX, positionY)]];
            else break;
        }
    }
    
    if([self containsDirection:RIGHT InDirection:self.moveDirection])
    {
        for(i = 1; i <= _range; i++)
        {
            newX = positionX + i;
            
            if(newX <= mapBoundaryX) [returnArray addObject:[NSValue valueWithCGPoint:CGPointMake(newX, positionY)]];
            else break;
        }
    }
    
    if([self containsDirection:FORWARDLEFT InDirection:self.moveDirection])
    {
        for(i = 1; i <= _range; i++)
        {
            newX = positionX - i;
            newY = positionY - i;
            
            if(newX >= 0 && newY >= 0) [returnArray addObject:[NSValue valueWithCGPoint:CGPointMake(newX, newY)]];
            else break;
        }
    }
    
    if([self containsDirection:FORWARDRIGHT InDirection:self.moveDirection])
    {
        for(i = 1; i <= _range; i++)
        {
            newX = positionX + i;
            newY = positionY - i;
            
            if(newX <= mapBoundaryX && newY >= 0) [returnArray addObject:[NSValue valueWithCGPoint:CGPointMake(newX, newY)]];
            else break;
        }
    }
    
    if([self containsDirection:BACKWARDLEFT InDirection:self.moveDirection])
    {
        for(i = 1; i <= _range; i++)
        {
            newX = positionX - i;
            newY = positionY + i;
            
            if(newX >= 0 && newY <= mapBoundaryY) [returnArray addObject:[NSValue valueWithCGPoint:CGPointMake(newX, newY)]];
            else break;
        }
    }
    
    if([self containsDirection:BACKWARDRIGHT InDirection:self.moveDirection])
    {
        for(i = 1; i <= _range; i++)
        {
            newX = positionX + i;
            newY = positionY + i;
            
            if(newX <= mapBoundaryX && newY <= mapBoundaryY) [returnArray addObject:[NSValue valueWithCGPoint:CGPointMake(newX, newY)]];
            else break;
        }
    }
    
      //Return CGPoint from array
//    NSValue *val = [points objectAtIndex:0];
//    CGPoint p = [val CGPointValue];
    
    return returnArray;
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
    return [NSString stringWithFormat:@"%@(%d)", _code, _player];
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
            output = [output stringByAppendingString:@"BACKWARDRIGHT, "];
            directionValue -= 128;
        }
        if(directionValue >= 64)
        {
            output = [output stringByAppendingString:@"BACKWARDLEFT, "];
            directionValue -= 64;
        }
        if(directionValue >= 32)
        {
            output = [output stringByAppendingString:@"FORWARDRIGHT, "];
            directionValue -= 32;
        }
        if(directionValue >= 16)
        {
            output = [output stringByAppendingString:@"FORWARDLEFT, "];
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
            output = [output stringByAppendingString:@"BACKWARD, "];
            directionValue -= 2;
        }
        if(directionValue >= 1)
        {
            output = [output stringByAppendingString:@"FORWARD, "];
            directionValue -= 1;
        }
    }
    
    output = [output substringToIndex:output.length-2]; //for the last 'comma space'
    
    return output;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nPiece: %@ \n\tPlayer: %@ \n\tGear: \t%@ \n\tP-atk: \t%d \n\tM-atk: \t%d \n\tP-def: \t%d \n\tM-def: \t%d \n\tHp: \t%d \n\tRange: \t%d \n\tMove: \t%d \n\tMove direction: %@ \n\tAttack direction: %@", _name, _player, [_upgrade listOfUpgrades], [self physicalAttackPower], [self magicalAttackPower], [self physicalDefense], [self magicalDefense], [self healthPoints], [self range], [self movement], [self directionToString:_moveDirection], [self directionToString:_attackDirection]];
}

@end
