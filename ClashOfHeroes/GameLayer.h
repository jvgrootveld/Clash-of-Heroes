//
//  GameLayer.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 22-11-11.
//  Copyright Pro4all 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// GameLayer
@interface GameLayer : CCLayer
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
- (CGPoint)tilePosFromLocation:(CGPoint)location tileMap:(CCTMXTiledMap*)tileMap;

@property (nonatomic, retain) CCTMXTiledMap *map;
@property (nonatomic, retain) CCTMXLayer *mapLayer;
@property (nonatomic, retain) CCTMXLayer *junkLayer;
@property (nonatomic, retain) CCTMXLayer *metaLayer;
@property (nonatomic, retain) CCSprite *selectedSprite;

@end
