//
//  GameLayer.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 22-11-11.
//  Copyright Pro4all 2011. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"

// HelloWorldLayer implementation
@implementation GameLayer

@synthesize mapLayer = _mapLayer, map = _map, selectedSprite = _selectedSprite, junkLayer = _junkLayer, metaLayer = _metaLayer;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self = [super init]))
    {
        CCSprite* background = [CCSprite spriteWithFile:@"background.jpg"];
        background.tag = 1;
        background.anchorPoint = CGPointMake(0, 0);
        [self addChild:background];
        
		self.isTouchEnabled = YES;
        
		self.map = [CCTMXTiledMap tiledMapWithTMXFile:@"small.tmx"];
        [self.map setPosition:CGPointMake(5,5)];
		[self addChild:self.map z:0 tag:2];
        
        self.mapLayer = [self.map layerNamed:@"Ground"];        
        self.junkLayer = [self.map layerNamed:@"Junk"];
        self.metaLayer = [self.map layerNamed:@"meta"];
        [self.metaLayer setVisible:NO];
        
        self.selectedSprite = [CCSprite spriteWithFile:@"SelectedSprite.png"];
        [self.selectedSprite setOpacity:128];
        [self.map addChild:self.selectedSprite z: [[self.map children] count]];
        [self.selectedSprite retain];
        
        [self.selectedSprite setVisible:NO];
	}
    
	return self;
}

- (CGPoint)tilePosFromLocation:(CGPoint)location tileMap:(CCTMXTiledMap*)tileMap
{	
    CGPoint pos = ccpSub(location, tileMap.position);
    float halfMapWidth = tileMap.mapSize.width * 0.5f;
    float mapHeight = tileMap.mapSize.height;
    float tileWidth = tileMap.tileSize.width;
    float tileHeight = tileMap.tileSize.height;
    CGPoint tilePosDiv = CGPointMake(pos.x / tileWidth, pos.y / tileHeight);
    float inverseTileY = mapHeight - tilePosDiv.y;
    
    // Cast to int makes sure that result is in whole numbers
    float posX = (int)(inverseTileY + tilePosDiv.x - halfMapWidth);
    float posY = (int)(inverseTileY - tilePosDiv.x + halfMapWidth);
    
    // make sure coordinates are within isomap bounds
    posX = MAX(0, posX);
    posX = MIN(tileMap.mapSize.width - 1, posX);
    posY = MAX(0, posY);
    posY = MIN(tileMap.mapSize.height - 1, posY);
    
    return CGPointMake(posX, posY);
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchObject = [touch locationInView: [touch view]];
    touchObject = [[CCDirector sharedDirector] convertToGL:touchObject];
	touchObject = [self.map convertToNodeSpace:touchObject];
    
    NSLog(@"Touch began at tile: %@", NSStringFromCGPoint([self tilePosFromLocation:touchObject tileMap:self.map]));
    
    CGPoint selectedTilePoint = [self tilePosFromLocation:touchObject tileMap:self.map];
    //if (selectedTilePoint.y != 0) selectedTilePoint.y -= 1;
    NSLog(@"%@", NSStringFromCGPoint(selectedTilePoint));
    
    CGPoint pos = [[self.metaLayer tileAt:selectedTilePoint] position];
    pos.x += (self.map.mapSize.width/2) + (self.map.tileSize.width/2);
    pos.y += (self.map.mapSize.height/2) + (self.map.tileSize.height/2);
    
    [self.selectedSprite setPosition:pos];
    [self.selectedSprite setVisible:YES];
    
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{        
    //[self.selectedSprite setAnchorPoint:[self touchToXY:[touch locationInView: [touch view]]]];
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"Touch cancelled");
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    //Moving the map across the screen
    
//    CGPoint touchLocation = [touch locationInView: [touch view]];	
//    CGPoint prevLocation = [touch previousLocationInView: [touch view]];	
//    	
//    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
//    prevLocation = [[CCDirector sharedDirector] convertToGL: prevLocation];
//    	
//    CGPoint diff = ccpSub(touchLocation,prevLocation);
//    	
//    CCNode *node = [self getChildByTag:2];
//    CGPoint currentPos = [node position];
//    [node setPosition: ccpAdd(currentPos, diff)];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
