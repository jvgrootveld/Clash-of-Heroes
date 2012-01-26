//
//  defaultBoardFactory.m
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 1/9/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "DefaultBoardFactory.h"
//#import "Player.h"
#import "GameLayer.h"

#import "Warrior.h"
#import "Mage.h"
#import "Ranger.h"
#import "Priest.h"
#import "Shapeshifter.h"

@implementation DefaultBoardFactory

+ (void)createBoardOnLayer:(GameLayer *)layer withPlayer1:(Player *)player1 andPlayer2:(Player *)player2;
{    
//    CGFloat spriteWidth = 26;
//    CGFloat spriteHeight = 62;
    
    NSInteger tag = 100; //start tag player 1 (player 2 starts with hero at 200)
    NSInteger locationX = 5; //start location
    
    //__hero with tag 100;
    tag++;
    
    //__WARRIOR
    CCSprite *unit = [[Warrior alloc] initForPlayer:player1 withTag:tag];
    
    //0-14
    [layer setSprite:unit atPositionPoint:CGPointMake(locationX, 14) withTag:tag];
    
    tag++;
    locationX++;
    
    //__MAGE
    unit = [[Mage alloc] initForPlayer:player1 withTag:tag];
    
    [layer setSprite:unit atPositionPoint:CGPointMake(locationX, 14) withTag:tag];
    
    tag++;
    locationX++;
    
    //__RANGER
    unit = [[Ranger alloc] initForPlayer:player1 withTag:tag];
    
    [layer setSprite:unit atPositionPoint:CGPointMake(locationX, 14) withTag:tag];
    
    tag++;
    locationX++;
    
    //__PRIEST
    unit = [[Priest alloc] initForPlayer:player1 withTag:tag];
    
    [layer setSprite:unit atPositionPoint:CGPointMake(locationX, 14) withTag:tag];
    
    tag++;
    locationX++;
    
    //__SHAPSHIFTER
    unit = [[Shapeshifter alloc] initForPlayer:player1 withTag:tag];
    
    [layer setSprite:unit atPositionPoint:CGPointMake(locationX, 14) withTag:tag];
    
    tag++;
    locationX++;
}

@end
