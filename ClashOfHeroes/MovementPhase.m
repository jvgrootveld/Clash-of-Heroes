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
#import "GameViewController.h"

@interface MovementPhase()

@property (nonatomic, strong) Unit *selectedUnit;

@end

NSInteger const MAXMOVES = 3;

@implementation MovementPhase

@synthesize gameLayer = _gameLayer, selectedUnit = _selectedUnit, remainingMoves = _remainingMoves;

- (id)initWithGameLayer:(GameLayer *)gameLayer;
{
    if (self = [super init])
    {
        _gameLayer = gameLayer;
        [self setRemainingMoves:MAXMOVES];
    }
    
    return self;
}

- (void)didSelectPoint:(CGPoint)point
{    
    CGPoint squarePoint = [_gameLayer tilePosFromLocation:point tileMap:_gameLayer.map]; //for selection tile, default is point, can be set for sprite/unit
    CCSprite *selectedSprite = [_gameLayer selectSpriteForTouch:point];
    Unit *friendlyUnit = ((selectedSprite) ? [_gameLayer isFriendlyUnitWithSprite:selectedSprite] : nil);
    Unit *enemyUnit = ((selectedSprite) ? [_gameLayer isEnemyUnitWithSprite:selectedSprite]: nil);
    
    NSLog(@"Selected: %@(%@)", NSStringFromCGPoint(point), NSStringFromCGPoint(squarePoint));
    
    if (!self.selectedUnit) //NO UNIT SELECTED YET
    {   
        if (!selectedSprite) //SELECTED EMPTY SQUARE
        {
            NSLog(@"Selected empty square");
            
            [_gameLayer.gameViewController hidePlayerLabels];
        }
        else if (friendlyUnit) //SELECTED UNIT IS FRIENDLY
        {
            self.selectedUnit = friendlyUnit;
            
            NSLog(@"Selected friendly unit: %@", self.selectedUnit.name);
            
            squarePoint = [_gameLayer tilePosFromLocation:self.selectedUnit.positionInPixels tileMap:_gameLayer.map];
            
            if(self.remainingMoves > 0)
            {
                NSArray *moveLocations = [self.selectedUnit pointsWhichCanBeMovedAtInLayer:_gameLayer];
                [_gameLayer showMoveTileAtPositionPoints:moveLocations];
            }
            
            [_gameLayer.gameViewController updatePlayerOneUnit:friendlyUnit];
        }
        else if (enemyUnit) //SELECTED UNIT IS NOT FRIENDLY
        {
            NSLog(@"Selected enemy unit: %@", enemyUnit.name);
            
            squarePoint = [_gameLayer tilePosFromLocation:enemyUnit.positionInPixels tileMap:_gameLayer.map];
            
            [_gameLayer.gameViewController updatePlayerTwoUnit:enemyUnit];
        }
    }
    else //ALREADY SELECTED A UNIT
    {   
        if (!selectedSprite) //SELECTED EMPTY SQUARE -> MOVE & DESELECT
        {
            if(self.remainingMoves > 0)
            {
                NSLog(@"Selected empty square, moving and deselecting unit.");
                
                NSArray *moveLocations = [self.selectedUnit pointsWhichCanBeMovedAtInLayer:_gameLayer];
                
                for(NSValue *location in moveLocations)
                {
                    CGPoint movePoint = [location CGPointValue];

                    if(CGPointEqualToPoint(squarePoint, movePoint)) //if unit can move to selected point
                    {
                        if([_gameLayer moveSprite:self.selectedUnit toTileLocation:point])
                            self.remainingMoves--;
                        
                        break;
                    }
                }
            }
            
            self.selectedUnit = nil;
            [_gameLayer removeMoveTiles]; //deselect movement tiles
            [_gameLayer.gameViewController hidePlayerLabels];
        }
        else if (friendlyUnit) //SELECTED FRIENDLY UNIT -> RESELECT UNIT
        {
            self.selectedUnit = friendlyUnit;
            NSLog(@"Selected friendly unit: %@, reselecting unit.", self.selectedUnit.name);
            
            squarePoint = [_gameLayer tilePosFromLocation:self.selectedUnit.positionInPixels tileMap:_gameLayer.map];
            
            if(self.remainingMoves > 0)
            {
                NSArray *moveLocations = [self.selectedUnit pointsWhichCanBeMovedAtInLayer:_gameLayer];
                [_gameLayer showMoveTileAtPositionPoints:moveLocations];
            }
            
            [_gameLayer.gameViewController updatePlayerOneUnit:friendlyUnit];
        }
        else if (enemyUnit) //SELECTED ENEMY UNIT -> DESELECT
        {
            self.selectedUnit = nil;
            NSLog(@"Selected enemy unit: %@, deselecting unit.", enemyUnit.name);
            
            squarePoint = [_gameLayer tilePosFromLocation:enemyUnit.positionInPixels tileMap:_gameLayer.map];
            [_gameLayer.gameViewController updatePlayerTwoUnit:enemyUnit];
        }
    }
    
    [_gameLayer showSelectionTileAtPositionPoint:squarePoint];
}

- (void)endPhase
{
    [_gameLayer removeMoveTiles];
    [_gameLayer setCurrentPhase:_gameLayer.combatPhase];
    self.remainingMoves = MAXMOVES;
    
    [_gameLayer.gameViewController updateLabels];
}

- (void)setRemainingMoves:(NSInteger)remainingMoves
{
    _remainingMoves = remainingMoves;
    [_gameLayer.gameViewController updateLabels];
}

- (NSString *)description
{
    return @"Movement Phase";
}

@end
