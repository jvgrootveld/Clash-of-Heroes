//
//  GameLayer.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 22-11-11.
//  Copyright Pro4all 2011. All rights reserved.
//

@class GameViewController;

// GameLayer
@interface GameLayer : CCLayer
{
    CCSprite *_selectedSprite;
    NSMutableArray *_moveSprites;
}

@property (nonatomic, strong) NSMutableArray *items;

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

/** This function gets the specific tile and move the sprite*/
- (void)moveSprite:(CCSprite *)sprite toTileLocation:(CGPoint)tileLocation;


- (CCSprite *)selectSpriteForTouch:(CGPoint)touchLocation;

@property (nonatomic, retain) CCTMXTiledMap *map;
@property (nonatomic, retain) CCTMXLayer *mapLayer;
@property (nonatomic, retain) CCTMXLayer *junkLayer;
@property (nonatomic, retain) CCTMXLayer *metaLayer;
@property (nonatomic, retain) CCSprite *selectedSprite;
@property (nonatomic, retain) GameViewController *gameViewController;

@end
