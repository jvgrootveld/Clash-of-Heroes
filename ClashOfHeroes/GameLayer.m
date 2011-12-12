//
//  GameLayer.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 22-11-11.
//  Copyright Pro4all 2011. All rights reserved.
//

// Import the interfaces
#import "GameLayer.h"
#import "TestPlayer.h"

@interface GameLayer()

@end

// HelloWorldLayer implementation
@implementation GameLayer

@synthesize mapLayer = _mapLayer, map = _map, selectedSprite = _selectedSprite, junkLayer = _junkLayer, metaLayer = _metaLayer, gameViewController = _gameViewController;

+ (CCScene *)sceneWithDelegate:(GameViewController *)delegate;
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
    [layer setGameViewController:delegate];
	
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
        
//        _mapTest = [CCLayer new];
//        _mapTest.isTouchEnabled = YES;
//        [_mapTest addChild:self.map z:0 tag:1];
        
        //[self addChild:_mapTest];
        
        self.mapLayer = [self.map layerNamed:@"Ground"];
        self.junkLayer = [self.map layerNamed:@"Junk"];
        self.metaLayer = [self.map layerNamed:@"meta"];
        [self.metaLayer setVisible:NO];
        
        self.selectedSprite = [CCSprite spriteWithFile:@"SelectedSprite.png"];
        [self.selectedSprite setOpacity:128];
        [self.map addChild:self.selectedSprite z: [[self.map children] count]];
        [self.selectedSprite retain];
        
        [self.selectedSprite setVisible:NO];
        
        
        CGFloat spriteWidth = 85;
        CGFloat spriteHeight = 121;
        

//        CCSprite *sprite = [CCSprite spriteWithFile:@"grossini_dance_atlas.png" rect:CGRectMake(spriteWidth*4, 0,spriteWidth, spriteHeight)];
//        [sprite setAnchorPoint:ccp(0.5f, 0.0f)];
//        [self setSprite:sprite atPositionPoint:CGPointMake(14, 5) withTag:200];
        
        spriteWidth = 26;
        spriteHeight = 62;
        _items = [NSMutableArray new];
        
        CCSprite *sprite = [CCSprite spriteWithFile:@"sprites.png" rect:CGRectMake(10, 10, spriteWidth, spriteHeight)];
        [sprite setAnchorPoint:ccp(0.5f, 0.0f)];
        [_items addObject:sprite];
        [self setSprite:sprite atPositionPoint:CGPointMake(14, 5) withTag:200];
        
        sprite = [CCSprite spriteWithFile:@"sprites.png" rect:CGRectMake(10, 10, spriteWidth, spriteHeight)];
        [sprite setAnchorPoint:ccp(0.5f, 0.0f)];
        [_items addObject:sprite];
        [self setSprite:sprite atPositionPoint:CGPointMake(14, 7) withTag:201];
        
        sprite = [CCSprite spriteWithFile:@"sprites.png" rect:CGRectMake(10, 10, spriteWidth, spriteHeight)];
        [sprite setAnchorPoint:ccp(0.5f, 0.0f)];
        [_items addObject:sprite];
        [self setSprite:sprite atPositionPoint:CGPointMake(12, 3) withTag:202];
        
        sprite = [CCSprite spriteWithFile:@"sprites.png" rect:CGRectMake(10, 10, spriteWidth, spriteHeight)];
        [sprite setAnchorPoint:ccp(0.5f, 0.0f)];
        [_items addObject:sprite];
        [self setSprite:sprite atPositionPoint:CGPointMake(11, 5) withTag:203];
        
        for(int i = 0; i < 5; i++)
        {
            sprite = [CCSprite spriteWithFile:@"sprites.png" rect:CGRectMake(10, 10, spriteWidth, spriteHeight)];
            [sprite setAnchorPoint:ccp(0.5f, 0.0f)];
            [_items addObject:sprite];
            [self setSprite:sprite atPositionPoint:CGPointMake(i, i) withTag:204+i];
        }
//        
//        
//        sprite.position = ccp(100, 100);
        
//        TestPlayer *test = [[TestPlayer alloc] initWithSizes:CGSizeMake(spriteWidth, spriteHeight)];
//        [test setPosition:CGPointMake(200, 100)];
//        [self addChild:test z:0 tag:5000];

//        for (int row = 0; row <= 14; row++) 
//        {
//            for(int column = 0; column <= 14; column++)
//            {
//                CCSprite *sprite = [CCSprite spriteWithFile:@"grossini_dance_atlas.png" rect:CGRectMake(spriteWidth*4, 0,spriteWidth, spriteHeight)];
//                
//                int tag = row+column;
//                
//                [self setSprite:sprite atPositionPoint:CGPointMake(row, column) withTag:tag];
//            }
//        }
        
//        CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"grossini_dance_atlas.png"];
//        [self addChild:batch];
//        
//        for (int i = 0; i < spriteWidth*4; i += spriteWidth)
//        {
//            CCSprite *sprite = [CCSprite spriteWithFile:@"grossini_dance_atlas.png" rect:CGRectMake(i, 0,spriteWidth, spriteHeight)];
//            [batch addChild:sprite];
//        }
//        
//        [self addChild:batch z:1 tag:10];
//        
//        CCArray* men = [batch children];
//        CCNode* node = [men objectAtIndex:0];
        
	}
    
	return self;
}

- (void)showSelectionTileAtLocation:(CGPoint)location
{
    CGPoint selectedTilePoint = [self tilePosFromLocation:location tileMap:self.map];
    
    NSLog(@"Touch at tile: %@", NSStringFromCGPoint(selectedTilePoint));
    
    CGPoint pos = [[self.metaLayer tileAt:selectedTilePoint] position];
    
    //NSLog(@"real pos: %@", NSStringFromCGPoint(pos));
    
    pos.x += (self.map.tileSize.width / 2);
    pos.y += (self.map.tileSize.height / 2);
    
    //pos.x += (self.map.mapSize.width / 2) + (self.map.tileSize.width / 3);
    //pos.y += (self.map.mapSize.height / 2) + (self.map.tileSize.height / 3);
    
    [self.selectedSprite setPosition:pos];
    [self.selectedSprite setVisible:YES];
}

- (void)setSprite:(CCSprite *)sprite atPositionPoint:(CGPoint)position withTag:(NSInteger)tag;
{
    //NSLog(@"sprite paint at %@", NSStringFromCGPoint(position));
    
    CGFloat spriteWidth = sprite.contentSize.width;
    CGFloat spriteHeight = sprite.contentSize.height;
    
    CGFloat offsetX = 8;
    CGFloat offsetY = 16;
    
    //NSLog(@"sprite size: %f-%f", spriteWidth, spriteHeight);
    
    CGPoint pos = [[self.metaLayer tileAt:position] position];
    
    pos.x += (self.map.tileSize.width / 2);
    pos.y += (self.map.tileSize.height / 2);
    
//    CGFloat x = pos.x + (spriteWidth / 2);
//    CGFloat y = pos.y + (spriteHeight / 2);
    
    [sprite setPosition:pos];

    //NSLog(@"tag: %d", tag);
    
    int newZ = (pos.y * -1) + 1000;
    //[self reorderChild:sprite z:newZ];
    
    [self addChild:sprite z:newZ tag:tag];
}

- (void)moveSprite:(CCSprite *)sprite toTileLocation:(CGPoint)tileLocation
{
    //Tile location
    CGPoint selectedTilePoint = [self tilePosFromLocation:tileLocation tileMap:self.map];
    
    NSLog(@"Move sprite to: %@", NSStringFromCGPoint(selectedTilePoint));
    
    CGPoint pos = [[self.metaLayer tileAt:selectedTilePoint] position];
    
    //pos.x += (self.map.mapSize.width / 2) + (self.map.tileSize.width / 2);
    //pos.y += (self.map.mapSize.height / 2) + (self.map.tileSize.height / 2);
    
    //sprite
    ccTime actualDuration = 1.0;
    
    CGFloat offsetX = 8;
    CGFloat offsetY = 16;
    
    pos.x += (self.map.tileSize.width / 2);
    pos.y += (self.map.tileSize.height / 2);
    
    pos.y -= sprite.position.y;
    pos.x -= sprite.position.x;

    // Create the actions
    id actionMove = [CCMoveBy actionWithDuration:actualDuration
                                        position:pos];

    [sprite runAction: [CCSequence actions:actionMove, nil]];
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

- (CCSprite *)selectSpriteForTouch:(CGPoint)touchLocation 
{
    //NSLog(@"search %d sprites", [_items count]);
    
    for (CCSprite *element in _items) 
    {
        if (CGRectContainsPoint(element.boundingBox, touchLocation)) 
        {
            NSLog(@"sprite was touched");
            //[element removeFromParentAndCleanup:YES];
            return element;
        }
    }
    
    NSLog(@"no sprites found on touch");
    return nil;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
	touchLocation = [self.map convertToNodeSpace:touchLocation];
    
    [self showSelectionTileAtLocation:touchLocation];
    
//    TestPlayer *test = (TestPlayer *)[self getChildByTag:5000];
//    NSLog(@"type: %@", [self getChildByTag:5000].class);
//    [test animate];
    
//    CCSprite *sprite = (CCSprite *)[self getChildByTag:200];
//    
//    [self moveSprite:sprite toTileLocation:touchLocation];
    
    CCSprite *sprite = [self selectSpriteForTouch:touchLocation];
    
    if(!sprite && _selectedSprite)
    {
        NSLog(@"move");
        [self moveSprite:_selectedSprite toTileLocation:touchLocation];
        _selectedSprite = nil;
    }
    else if (sprite) _selectedSprite = sprite;
    
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
