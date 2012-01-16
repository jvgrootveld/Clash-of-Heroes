//
//  MovementPhase.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 16-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "MovementPhase.h"
#import "GameLayer.h"

@interface MovementPhase()

@property (nonatomic) CGPoint selectedSquare;
@property (nonatomic) NSInteger remainingMoves;

@end

NSInteger const MAXMOVES = 3;

@implementation MovementPhase

@synthesize selectedSquare = _selectedSquare, remainingMoves = _remainingMoves;

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
    
}

- (void)endPhaseOnLayer:(GameLayer *)layer
{
    [layer setCurrentPhase:layer.combatPhase];
}

@end
