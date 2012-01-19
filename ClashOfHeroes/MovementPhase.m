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
        if ([layer selectSpriteForTouch:squarePoint] == nil)
        {
            
        }
    }
}

- (void)endPhaseOnLayer:(GameLayer *)layer
{
    [layer setCurrentPhase:layer.combatPhase];
}

- (NSString *)description
{
    return @"Movement Phase";
}

@end
