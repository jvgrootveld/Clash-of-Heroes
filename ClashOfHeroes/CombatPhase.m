//
//  CombatPhase.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 16-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "CombatPhase.h"
#import "GameLayer.h"
#import "Unit.h"

@interface CombatPhase()

@property (nonatomic, strong) Unit *selectedUnit;

@end

NSInteger const MAXACTIONS = 3;

@implementation CombatPhase

@synthesize selectedUnit = _selectedUnit, remainingMoves = _remainingMoves;

- (id)init
{
    if (self = [super init])
    {
        [self setRemainingMoves:MAXACTIONS];
    }
    
    return self;
}

- (void)didSelectPoint:(CGPoint)point onLayer:(GameLayer *)layer
{
    if (self.selectedUnit == nil) //NO UNIT SELECTED YET
    {
        CCSprite *selectedSprite = [layer selectSpriteForTouch:point];
        
        if (selectedSprite == nil) //SELECTED EMPTY SQUARE
        {
            NSLog(@"Selected empty square");
        }
        else if ([layer isFriendlyUnitWithSprite:selectedSprite] != nil) //SELECTED FRIENDLY UNIT -> SELECT UNIT
        {
            self.selectedUnit = [layer isFriendlyUnitWithSprite:selectedSprite];
            NSLog(@"Selected friendly unit: %@", self.selectedUnit.name);
        }
        else if ([layer isEnemyUnitWithSprite:selectedSprite] != nil) //SELECTED ENEMY UNIT
        {
            NSLog(@"Selected enemy unit: %@", [layer isEnemyUnitWithSprite:selectedSprite].name);
        }
    }
    else //ALREADY SELECTED A UNIT
    {
        CCSprite *selectedSprite = [layer selectSpriteForTouch:point];
        
        if (selectedSprite == nil && !(self.remainingMoves <= 0)) //SELECTED EMPTY SQUARE -> DESELECT
        {
            NSLog(@"Selected empty square, deselecting unit.");
            self.selectedUnit = nil;
        }
        else if ([layer isFriendlyUnitWithSprite:selectedSprite] != nil && !(self.remainingMoves <= 0)) //SELECTED FRIENDLY UNIT -> BUFF
        {
            NSLog(@"Selected friendly unit: %@. Healing/casting buff on unit with %@ and deselecting unit.", [layer isFriendlyUnitWithSprite:selectedSprite].name, self.selectedUnit.name);
            self.remainingMoves--;
            self.selectedUnit = nil;
        }
        else if ([layer isEnemyUnitWithSprite:selectedSprite] != nil && !(self.remainingMoves <= 0)) //SELECTED UNFRIENDLY UNIT -> ATTACK
        {
            NSLog(@"Selected enemy unit: %@, attacking with %@ deselecting unit.", [layer isEnemyUnitWithSprite:selectedSprite].name, self.selectedUnit.name);
            self.remainingMoves--;
            self.selectedUnit = nil;
        }
    }
}

- (void)endPhaseOnLayer:(GameLayer *)layer
{
    [layer setCurrentPhase:layer.movementPhase];
}

- (NSString *)description
{
    return @"Combat Phase";
}

@end