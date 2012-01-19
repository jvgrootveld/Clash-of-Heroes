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
