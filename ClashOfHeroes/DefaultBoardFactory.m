//
//  defaultBoardFactory.m
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 1/9/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "DefaultBoardFactory.h"
#import "Player.h"
#import "GameLayer.h"
#import "UnitData.h"
#import "Unit.h"
#import "Warrior.h"
#import "Mage.h"
#import "Ranger.h"
#import "Priest.h"
#import "Shapeshifter.h"

@interface DefaultBoardFactory()

+ (void)createBoardForPlayer:(Player *)player onLayer:(GameLayer *)layer;

@end

@implementation DefaultBoardFactory

+ (void)createBoardOnLayer:(GameLayer *)layer withPlayer1:(Player *)player1 andPlayer2:(Player *)player2;
{
    
    [self createBoardForPlayer:player1 onLayer:layer];
    [self createBoardForPlayer:player2 onLayer:layer];
}

+ (void)createBoardForPlayer:(Player *)player onLayer:(GameLayer *)layer
{
    [player resetUnits];
    NSArray *playerData = player.unitData;
    Unit *unit;
    
    for (UnitData *unitData in playerData)
    {
        CGPoint location = unitData.location;
        if ((player == [[GCTurnBasedMatchHelper sharedInstance] playerForEnemyPlayer]) && [[GCTurnBasedMatchHelper sharedInstance] playerForLocalPlayer].turnNumber > 0)
        {
            location = CGPointMake((14-unitData.location.x), (14-unitData.location.y));
        }
        
        NSLog(@"Placing unit %@ for player %@ on point %@", unitData.unitName, player.gameCenterInfo.alias, [NSValue valueWithCGPoint:location]);
        
        switch (unitData.unitType) 
        {
            case WARRIOR:
                unit = [[Warrior alloc] initForPlayer:player withTag:unitData.tag];
                [unit setHealthPoints:unitData.currentHealth];
                [layer setSprite:unit atPositionPoint:location withTag:unitData.tag];
                break;
            case MAGE:
                unit = [[Mage alloc] initForPlayer:player withTag:unitData.tag];
                [unit setHealthPoints:unitData.currentHealth];
                [layer setSprite:unit atPositionPoint:location withTag:unitData.tag];
                break;
            case RANGER:
                unit = [[Ranger alloc] initForPlayer:player withTag:unitData.tag];
                [unit setHealthPoints:unitData.currentHealth];
                [layer setSprite:unit atPositionPoint:location withTag:unitData.tag];
                break;
            case PRIEST:
                unit = [[Priest alloc] initForPlayer:player withTag:unitData.tag];
                [unit setHealthPoints:unitData.currentHealth];
                [layer setSprite:unit atPositionPoint:location withTag:unitData.tag];
                break;
            case SHAPESHIFTER:
                unit = [[Shapeshifter alloc] initForPlayer:player withTag:unitData.tag];
                [unit setHealthPoints:unitData.currentHealth];
                [layer setSprite:unit atPositionPoint:location withTag:unitData.tag];
                break;
            default:
                break;
        }
    }
}

@end
