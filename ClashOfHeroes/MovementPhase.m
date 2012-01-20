//
//  MovementPhase.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 16-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "MovementPhase.h"
#import "GameLayer.h"
#import "Unit.h"

@interface MovementPhase()

@property (nonatomic, strong) Unit *selectedUnit;

@end

NSInteger const MAXMOVES = 3;

@implementation MovementPhase

@synthesize selectedUnit = _selectedUnit, remainingMoves = _remainingMoves;

- (id)init
{
    if (self = [super init])
    {
        [self setRemainingMoves:MAXMOVES];
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
            NSLog(@"Selected empty square, moving and deselecting unit.");
            self.remainingMoves--;
            self.selectedUnit = nil;
        }
        else if ([layer isFriendlyUnitWithSprite:selectedSprite] != nil)
        {
            self.selectedUnit = [layer isFriendlyUnitWithSprite:selectedSprite];
            NSLog(@"Selected friendly unit: %@, reselecting unit.", self.selectedUnit.name);
        }
        else if ([layer isEnemyUnitWithSprite:selectedSprite] != nil)
        {
            self.selectedUnit = nil;
            NSLog(@"Selected enemy unit: %@, deselecting unit.", [layer isEnemyUnitWithSprite:selectedSprite].name);
        }
    }
}

- (void)endPhaseOnLayer:(GameLayer *)layer
{
    [layer setCurrentPhase:layer.combatPhase];
    self.remainingMoves = MAXMOVES;
}

- (NSString *)description
{
    return @"Movement Phase";
}

@end
