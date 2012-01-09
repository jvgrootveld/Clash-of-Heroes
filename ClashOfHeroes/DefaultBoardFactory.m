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

#import "WarriorUnitFactory.h"
#import "MageUnitFactory.h"
#import "RangerUnitFactory.h"
#import "PriestUnitFactory.h"
#import "ShapeshifterUnitFactory.h"

@implementation DefaultBoardFactory

+ (void)createBoardOnLayer:(GameLayer *)layer withPlayer1:(Player *)player1 andPlayer2:(Player *)player2;
{
#warning handle in Player obj?
    //_items = [NSMutableArray new];
    
    CGFloat spriteWidth = 26;
    CGFloat spriteHeight = 62;
    
    CCSprite *sprite = [CCSprite spriteWithFile:@"sprites.png" rect:CGRectMake(10, 10, spriteWidth, spriteHeight)];
    [sprite setAnchorPoint:ccp(0.5f, 0.0f)];
    //[_items addObject:sprite];
    
    //0-14
    [layer setSprite:sprite atPositionPoint:CGPointMake(0, 14) withTag:200];
}

@end
