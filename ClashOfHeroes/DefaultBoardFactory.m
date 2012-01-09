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
#warning handle in Player obj?
    //_items = [NSMutableArray new];
    
    CGFloat spriteWidth = 26;
    CGFloat spriteHeight = 62;
    
    NSInteger tag = 100;
    NSInteger locationX = 5;
    
    //__hero with tag 100;
    tag++;
    
    //__WARRIOR
    [[Warrior alloc] initForPlayer:player1 withTag:tag];
    
    CCSprite *sprite = [CCSprite spriteWithFile:@"sprites.png" rect:CGRectMake(10, 10, spriteWidth, spriteHeight)];
    [sprite setAnchorPoint:ccp(0.5f, 0.0f)];
    
    //0-14
    [layer setSprite:sprite atPositionPoint:CGPointMake(locationX, 14) withTag:tag];
    
    tag++;
    locationX++;
    
    //__MAGE
    [[Mage alloc] initForPlayer:player1 withTag:tag];
    
    sprite = [CCSprite spriteWithFile:@"sprites.png" rect:CGRectMake(10, 10, spriteWidth, spriteHeight)];
    [sprite setAnchorPoint:ccp(0.5f, 0.0f)];
    
    //0-14
    [layer setSprite:sprite atPositionPoint:CGPointMake(locationX, 14) withTag:tag];
    
    tag++;
    locationX++;
    
    //__RANGER
    [[Ranger alloc] initForPlayer:player1 withTag:tag];
    
    sprite = [CCSprite spriteWithFile:@"sprites.png" rect:CGRectMake(10, 10, spriteWidth, spriteHeight)];
    [sprite setAnchorPoint:ccp(0.5f, 0.0f)];
    
    //0-14
    [layer setSprite:sprite atPositionPoint:CGPointMake(locationX, 14) withTag:tag];
    
    tag++;
    locationX++;
    
    //__PRIEST
    [[Priest alloc] initForPlayer:player1 withTag:tag];
    
    sprite = [CCSprite spriteWithFile:@"sprites.png" rect:CGRectMake(10, 10, spriteWidth, spriteHeight)];
    [sprite setAnchorPoint:ccp(0.5f, 0.0f)];
    
    //0-14
    [layer setSprite:sprite atPositionPoint:CGPointMake(locationX, 14) withTag:tag];
    
    tag++;
    locationX++;
    
    //__SHAPSHIFTER
    [[Shapeshifter alloc] initForPlayer:player1 withTag:tag];
    
    sprite = [CCSprite spriteWithFile:@"sprites.png" rect:CGRectMake(10, 10, spriteWidth, spriteHeight)];
    [sprite setAnchorPoint:ccp(0.5f, 0.0f)];
    
    //0-14
    [layer setSprite:sprite atPositionPoint:CGPointMake(locationX, 14) withTag:tag];
    
    tag++;
    locationX++;
}

@end
