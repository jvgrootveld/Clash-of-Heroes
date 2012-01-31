//
//  GameLayer.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 22-11-11.
//  Copyright Pro4all 2011. All rights reserved.
//

#import "Phase.h"

@class GameViewController;
@class MovementPhase;
@class CombatPhase;
@class Unit;
@class Turn;

// GameLayer
@interface GameLayer : CCLayer
{
    NSMutableArray *_moveSprites;
    NSMutableArray *_attackSprites;
}

@property (nonatomic, readonly) NSArray *units;
@property (nonatomic, strong) Turn *turn;

// returns a CCScene that contains the HelloWorldLayer as the only child
+ (CCScene *)sceneWithDelegate:(GameViewController *)delegate;
- (CGPoint)tilePosFromLocation:(CGPoint)location tileMap:(CCTMXTiledMap*)tileMap;

/** position like: 0-0, 12-4, etc NOT pixels */
- (void)setSprite:(CCSprite *)sprite atPositionPoint:(CGPoint)position withTag:(NSInteger)tag;

- (void)showSelectionTileAtLocation:(CGPoint)location;
/** position like: 0-0, 12-4, etc NOT pixels */
- (void)showSelectionTileAtPositionPoint:(CGPoint)position;

/** position like: 0-0, 12-4, etc NOT pixels */
- (void)showMoveTileAtPositionPoint:(CGPoint)position;
- (void)showMoveTileAtPositionPoints:(NSArray *)positions;
- (void)removeMoveTiles;
- (void)showAttackTileAtPositionPoint:(CGPoint)position;
- (void)showAttackTileAtPositionPoints:(NSArray *)positions;
- (void)removeAttackTiles;

/** This function gets the specific tile and move the sprite*/
- (BOOL)moveSprite:(CCSprite *)sprite toTileLocation:(CGPoint)tileLocation;

- (CGFloat)mapBoundaryX;
- (CGFloat)mapBoundaryY;

- (CCSprite *)selectSpriteForTouch:(CGPoint)touchLocation;
- (Unit *)isFriendlyUnitWithSprite:(CCSprite *)sprite;
- (Unit *)isEnemyUnitWithSprite:(CCSprite *)sprite;
- (BOOL)isEmptySquare:(CGPoint)squarePosition;
- (void)resetBoard; //clear sprites and reset turn object.
- (void)removeUnits;
- (void)removeUnit:(Unit *)unit;

- (BOOL)isLocationInBounds:(CGPoint)location;

- (void)presentMessage:(NSString *)message;

- (void)loadUnitLocations;

@property (nonatomic, retain) CCTMXTiledMap *map;
@property (nonatomic, retain) CCTMXLayer *mapLayer;
@property (nonatomic, retain) CCTMXLayer *junkLayer;
@property (nonatomic, retain) CCTMXLayer *metaLayer;
@property (nonatomic, retain) CCSprite *selectedSprite;
@property (nonatomic, retain) GameViewController *gameViewController;

@property (nonatomic, assign) id<Phase> currentPhase;
@property (nonatomic, assign) id<Phase> movementPhase;
@property (nonatomic, assign) id<Phase> combatPhase;

@end
