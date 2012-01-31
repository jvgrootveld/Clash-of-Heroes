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
#import "GameViewController.h"

@interface CombatPhase()

@property (nonatomic, strong) Unit *selectedUnit;

@end

NSInteger const MAXACTIONS = 3;

@implementation CombatPhase

@synthesize gameLayer = _gameLayer, selectedUnit = _selectedUnit, remainingMoves = _remainingMoves;

- (id)initWithGameLayer:(GameLayer *)gameLayer;
{
    if (self = [super init])
    {
        _gameLayer = gameLayer;
        [self setRemainingMoves:MAXACTIONS];
    }
    
    return self;
}

- (void)didSelectPoint:(CGPoint)point
{   
    CGPoint squarePoint = [_gameLayer tilePosFromLocation:point tileMap:_gameLayer.map]; //for selection tile, default is point, can be set for sprite/unit
    CCSprite *selectedSprite = [_gameLayer selectSpriteForTouch:point];
    Unit *friendlyUnit = ((selectedSprite) ? [_gameLayer isFriendlyUnitWithSprite:selectedSprite] : nil);
    Unit *enemyUnit = ((selectedSprite) ? [_gameLayer isEnemyUnitWithSprite:selectedSprite]: nil);
    
    if (!self.selectedUnit) //NO UNIT SELECTED YET
    {
        if (!selectedSprite) //SELECTED EMPTY SQUARE
        {
            NSLog(@"Selected empty square");
             [_gameLayer.gameViewController hidePlayerLabels];
        }
        else if (friendlyUnit) //SELECTED FRIENDLY UNIT -> SELECT UNIT
        {
            self.selectedUnit = friendlyUnit;
            NSLog(@"Selected friendly unit: %@", self.selectedUnit.name);
            
            squarePoint = [_gameLayer tilePosFromLocation:self.selectedUnit.positionInPixels tileMap:_gameLayer.map];
            
            if(self.remainingMoves > 0)
            {
                NSArray *attackLocations = [self.selectedUnit pointsWhichCanBeAttackedAtInLayer:_gameLayer];
                [_gameLayer showAttackTileAtPositionPoints:attackLocations];
            }
            
            [_gameLayer.gameViewController updatePlayerOneUnit:friendlyUnit];
        }
        else if (enemyUnit) //SELECTED ENEMY UNIT
        {
            NSLog(@"Selected enemy unit: %@", enemyUnit.name);
            [_gameLayer.gameViewController updatePlayerTwoUnit:enemyUnit];
        }
    }
    else //ALREADY SELECTED A UNIT
    {   
        if (!selectedSprite) //SELECTED EMPTY SQUARE -> DESELECT
        {
            NSLog(@"Selected empty square, deselecting unit.");
            [_gameLayer.gameViewController hidePlayerLabels];
        }
        else if (friendlyUnit) //SELECTED FRIENDLY UNIT -> BUFF                 (!!!!!NOT IMPLEMENTED YET!!!!!)
        {
            NSLog(@"Selected friendly unit: %@. Healing/casting buff on unit with %@ and deselecting unit.", friendlyUnit.name, self.selectedUnit.name);
            //self.remainingMoves--;
            [_gameLayer.gameViewController updatePlayerOneUnit:friendlyUnit];
        }
        else if (enemyUnit) //SELECTED UNFRIENDLY UNIT -> ATTACK
        {
            if(self.remainingMoves > 0)
            {
                NSLog(@"Selected enemy unit: %@, attacking with %@ deselecting unit.", enemyUnit.name, self.selectedUnit.name);
                
                NSArray *attackLocations = [self.selectedUnit pointsWhichCanBeAttackedAtInLayer:_gameLayer];
                
                for(NSValue *location in attackLocations)
                {
                    CGPoint attackPoint = [location CGPointValue];
                    
                    if(CGPointEqualToPoint(squarePoint, attackPoint)) //if unit can attack to selected point
                    {
                        if([self.selectedUnit attackUnit:enemyUnit onLayer:self.gameLayer])//if enemy is killed by last attack
                        {
                            [enemyUnit removeFromPlayer];
                            [self.gameLayer removeUnit:enemyUnit];
                        }
                        
                        self.remainingMoves--;
                        
                        break;
                    }
                }
            }
            [_gameLayer.gameViewController updatePlayerTwoUnit:enemyUnit];
        }
        
        self.selectedUnit = nil;
        [_gameLayer removeAttackTiles]; //deselect attack tiles
    }
    
    [_gameLayer showSelectionTileAtPositionPoint:squarePoint];
}

- (void)endPhase
{
    [_gameLayer setCurrentPhase:_gameLayer.movementPhase];
    [_gameLayer.gameViewController updateLabels];
}

- (void)setRemainingMoves:(NSInteger)remainingMoves
{
    _remainingMoves = remainingMoves;
    [_gameLayer.gameViewController updateLabels];
}

- (NSString *)description
{
    return @"Combat Phase";
}

@end
