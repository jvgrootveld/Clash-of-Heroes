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

- (void)didSelectSquare:(CGPoint)squarePoint onLayer:(GameLayer *)layer
{
    if (self.selectedUnit == nil)
    {
        CCSprite *selectedSprite = [layer selectSpriteForTouch:squarePoint];
        
        if (selectedSprite == nil)
        {
            NSLog(@"Selected empty square");
        }
        else if ([layer isFriendlyUnitWithSprite:selectedSprite] != nil)
        {
            self.selectedUnit = [layer isFriendlyUnitWithSprite:selectedSprite];
            NSLog(@"Selected friendly unit: %@", self.selectedUnit.name);
        }
        else if ([layer isEnemyUnitWithSprite:selectedSprite] != nil)
        {
            NSLog(@"Selected enemy unit: %@", [layer isEnemyUnitWithSprite:selectedSprite].name);
        }
    }
    else
    {
        CCSprite *selectedSprite = [layer selectSpriteForTouch:squarePoint];
        
        if (selectedSprite == nil && !(self.remainingMoves <= 0))
        {
            NSLog(@"Selected empty square, deselecting unit.");
            self.selectedUnit = nil;
        }
        else if ([layer isFriendlyUnitWithSprite:selectedSprite] != nil && !(self.remainingMoves <= 0))
        {
            NSLog(@"Selected friendly unit: %@. Healing/casting buff on unit with %@ and deselecting unit.", [layer isFriendlyUnitWithSprite:selectedSprite].name, self.selectedUnit.name);
            self.remainingMoves--;
            self.selectedUnit = nil;
        }
        else if ([layer isEnemyUnitWithSprite:selectedSprite] != nil && !(self.remainingMoves <= 0))
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
