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
    GCTurnBasedMatchHelper *helper = [GCTurnBasedMatchHelper sharedInstance];
    Player *localPlayer = [helper playerForLocalPlayer];
    Player *enemyPlayer = [helper playerForEnemyPlayer];
    
    [self createBoardForPlayer:localPlayer onLayer:layer];
    [self createBoardForPlayer:enemyPlayer onLayer:layer];
    
    //__WARRIOR
    //CCSprite *unit = [[Warrior alloc] initForPlayer:player1 withTag:tag];
    
    //0-14
    //[layer setSprite:unit atPositionPoint:CGPointMake(locationX, 14) withTag:tag];
}

+ (void)createBoardForPlayer:(Player *)player onLayer:(GameLayer *)layer
{
    NSArray *playerData = player.unitData;
    CCSprite *unit;
    
    if (player == [[GCTurnBasedMatchHelper sharedInstance] playerForLocalPlayer])
    {
        for (UnitData *unitData in playerData)
        {
            switch (unitData.unitType) {
                case WARRIOR:
                    unit = [[Warrior alloc] initForPlayer:player withTag:unitData.tag];
                    [layer setSprite:unit atPositionPoint:unitData.location withTag:unitData.tag];
                    break;
                case MAGE:
                    unit = [[Mage alloc] initForPlayer:player withTag:unitData.tag];
                    [layer setSprite:unit atPositionPoint:unitData.location withTag:unitData.tag];
                    break;
                case RANGER:
                    unit = [[Ranger alloc] initForPlayer:player withTag:unitData.tag];
                    [layer setSprite:unit atPositionPoint:unitData.location withTag:unitData.tag];
                    break;
                case PRIEST:
                    unit = [[Priest alloc] initForPlayer:player withTag:unitData.tag];
                    [layer setSprite:unit atPositionPoint:unitData.location withTag:unitData.tag];
                    break;
                case SHAPESHIFTER:
                    unit = [[Shapeshifter alloc] initForPlayer:player withTag:unitData.tag];
                    [layer setSprite:unit atPositionPoint:unitData.location withTag:unitData.tag];
                    break;
                default:
                    break;
            }
        }
    }
    else
    {
        for (UnitData *unitData in playerData)
        {
            CGPoint location = CGPointMake((14-unitData.location.x), (14-unitData.location.y));
            
            switch (unitData.unitType) {
                case WARRIOR:
                    unit = [[Warrior alloc] initForPlayer:player withTag:unitData.tag];
                    [layer setSprite:unit atPositionPoint:location withTag:unitData.tag];
                    break;
                case MAGE:
                    unit = [[Mage alloc] initForPlayer:player withTag:unitData.tag];
                    [layer setSprite:unit atPositionPoint:location withTag:unitData.tag];
                    break;
                case RANGER:
                    unit = [[Ranger alloc] initForPlayer:player withTag:unitData.tag];
                    [layer setSprite:unit atPositionPoint:location withTag:unitData.tag];
                    break;
                case PRIEST:
                    unit = [[Priest alloc] initForPlayer:player withTag:unitData.tag];
                    [layer setSprite:unit atPositionPoint:location withTag:unitData.tag];
                    break;
                case SHAPESHIFTER:
                    unit = [[Shapeshifter alloc] initForPlayer:player withTag:unitData.tag];
                    [layer setSprite:unit atPositionPoint:location withTag:unitData.tag];
                    break;
                default:
                    break;
            }
        }
    }
}

@end
