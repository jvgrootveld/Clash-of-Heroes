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

- (void)didSelectPoint:(CGPoint)point onLayer:(GameLayer *)layer
{    
    if (self.selectedUnit == nil) //NO UNIT SELECTED YET
    {
        CCSprite *selectedSprite = [layer selectSpriteForTouch:point];
        
        if (selectedSprite == nil) //SELECTED EMPTY SQUARE
        {
            NSLog(@"Selected empty square");
        }
        else if ([layer isFriendlyUnitWithSprite:selectedSprite] != nil) //SELECTED UNIT IS FRIENDLY
        {
            self.selectedUnit = [layer isFriendlyUnitWithSprite:selectedSprite];
            NSLog(@"Selected friendly unit: %@", self.selectedUnit.name);
        }
        else if ([layer isEnemyUnitWithSprite:selectedSprite] != nil) //SELECTED UNIT IS NOT FRIENDLY
        {
            NSLog(@"Selected enemy unit: %@", [layer isEnemyUnitWithSprite:selectedSprite].name);
        }
    }
    else //ALREADY SELECTED A UNIT
    {
        CCSprite *selectedSprite = [layer selectSpriteForTouch:point];
        
        if (selectedSprite == nil && !(self.remainingMoves <= 0)) //SELECTED EMPTY SQUARE -> MOVE & DESELECT
        {
            NSLog(@"Selected empty square, moving and deselecting unit.");
            self.remainingMoves--;
            self.selectedUnit = nil;
        }
        else if ([layer isFriendlyUnitWithSprite:selectedSprite] != nil) //SELECTED FRIENDLY UNIT -> RESELECT UNIT
        {
            self.selectedUnit = [layer isFriendlyUnitWithSprite:selectedSprite];
            NSLog(@"Selected friendly unit: %@, reselecting unit.", self.selectedUnit.name);
        }
        else if ([layer isEnemyUnitWithSprite:selectedSprite] != nil) //SELECTED ENEMY UNIT -> DESELECT
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
