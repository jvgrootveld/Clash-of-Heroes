//
//  GameLayer.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 22-11-11.
//  Copyright Pro4all 2011. All rights reserved.
//

// Import the interfaces
#import "GameLayer.h"
#import "GameViewController.h"
#import "TestPlayer.h"
#import "GCTurnBasedMatchHelper.h"
#import "Player.h"
#import "Unit.h"
#import "MovementPhase.h"
#import "CombatPhase.h"
#import "DefaultBoardFactory.h"
#import "CDPlayer.h"
#import "CDStats.h"
#import "Turn.h"

@interface GameLayer()

@end

@implementation GameLayer

@synthesize mapLayer = _mapLayer, map = _map, selectedSprite = _selectedSprite, junkLayer = _junkLayer, metaLayer = _metaLayer, gameViewController = _gameViewController, currentPhase = _currentPhase, combatPhase = _combatPhase, movementPhase = _movementPhase, turn = _turn;

+ (CCScene *)sceneWithDelegate:(GameViewController *)delegate;
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
    [layer setGameViewController:delegate];
    [delegate setGameLayer:layer];
    
    [layer loadUnitLocations];
    
    [layer setMovementPhase:[[MovementPhase alloc] initWithGameLayer:layer]];
    [layer setCombatPhase:[[CombatPhase alloc] initWithGameLayer:layer]];
    [layer setCurrentPhase:layer.movementPhase];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)loadUnitLocations
{
    NSLog(@"load units");
    [self resetBoard];
    
    GCTurnBasedMatchHelper *gCTurnBasedMatchHelper = [GCTurnBasedMatchHelper sharedInstance];
    Player *player1 = [gCTurnBasedMatchHelper playerForLocalPlayer];
    Player *player2 = [gCTurnBasedMatchHelper playerForEnemyPlayer];
    
    [DefaultBoardFactory createBoardOnLayer:self withPlayer1:player1 andPlayer2:player2];
}

// on "init" you need to initialize your instance
- (id)init
{
	if( (self = [super init]))
    {
        CCSprite* background = [CCSprite spriteWithFile:@"background.jpg"];
        background.tag = 1;
        background.anchorPoint = CGPointMake(0, 0);
        [self addChild:background];
        
		self.isTouchEnabled = YES;
        
		self.map = [CCTMXTiledMap tiledMapWithTMXFile:@"planes.tmx"];
        [self.map setPosition:CGPointMake(5,5)];
		[self addChild:self.map z:0 tag:2];
        
        self.mapLayer = [self.map layerNamed:@"Ground"];
        self.junkLayer = [self.map layerNamed:@"Junk"];
        self.metaLayer = [self.map layerNamed:@"meta"];
        [self.metaLayer setVisible:NO];
        
        self.selectedSprite = [CCSprite spriteWithFile:@"tile_blue.png"];
        [self.selectedSprite setOpacity:128];
        [self.map addChild:self.selectedSprite z: [[self.map children] count]];
        [self.selectedSprite retain];
        
        [self.selectedSprite setVisible:NO];
        
        CGFloat spriteWidth = 85;
        CGFloat spriteHeight = 121;
        
        spriteWidth = 26;
        spriteHeight = 62;
        _moveSprites = [NSMutableArray new];
        _attackSprites = [NSMutableArray new];
        self.turn = [Turn new];
	}
    
	return self;
}

- (BOOL)isTilePosBlocked:(CGPoint)tilePos
{
    unsigned int tileGID = [self.metaLayer tileGIDAt:tilePos];
    //NSLog(@"tileGID: %d", tileGID);
    
    //outside, water or grass   =  0
    //weird left tile           = 25
    //good                      =  1
    if(tileGID != 1)
    {
        return YES;
//        NSDictionary *tileProperties = [self.map propertiesForGID:tileGID];
//        NSLog(@"tileProperties: %@", tileProperties);
//        id selectable = [tileProperties objectForKey:@"selectable"];
//        NSLog(@"blocked: %@", selectable);
//        isBlocked = (selectable == nil);
    }
    
    return NO;
}

- (void)showSelectionTileAtLocation:(CGPoint)location
{
    CGPoint position = [self tilePosFromLocation:location tileMap:self.map];
    
    [self showSelectionTileAtPositionPoint:position];
}

- (void)showSelectionTileAtPositionPoint:(CGPoint)position
{
    if([self isLocationInBounds:position])
    {
        if(![self isTilePosBlocked:position])
        {
            //NSLog(@"Show selection tile at: %@", NSStringFromCGPoint(position));
            
            CGPoint pos = [[self.metaLayer tileAt:position] position];
            
            //NSLog(@"real pos: %@", NSStringFromCGPoint(pos));
            
            pos.x += (self.map.tileSize.width / 2);
            pos.y += (self.map.tileSize.height / 2);
            
            //pos.x += (self.map.mapSize.width / 2) + (self.map.tileSize.width / 3);
            //pos.y += (self.map.mapSize.height / 2) + (self.map.tileSize.height / 3);
            
            [self.selectedSprite setPosition:pos];
            [self.selectedSprite setVisible:YES];
        }
        else
        {
            [self.selectedSprite setVisible:NO];
            NSLog(@"Show selection tile at: tile blocked: %@", NSStringFromCGPoint(position));
        }
    }
    else
    {
        [self.selectedSprite setVisible:NO];
        NSLog(@"Show selection tile at: invalid position: %@", NSStringFromCGPoint(position));
    }
}

- (void)showMoveTileAtPositionPoint:(CGPoint)position
{
    if([self isLocationInBounds:position])
    {
        if(![self isTilePosBlocked:position])
        {   
            CGPoint pos = [[self.metaLayer tileAt:position] position];
            
            pos.x += (self.map.tileSize.width / 2);
            pos.y += (self.map.tileSize.height / 2);
            
            CCSprite *moveSprite = [CCSprite spriteWithFile:@"tile_green.png"];
            [moveSprite setTag:100];//needed?
            [moveSprite setOpacity:128];
            [self.map addChild:moveSprite z:1];
            [_moveSprites addObject:moveSprite];
            [moveSprite setPosition:pos];
        }
        else
        {
            NSLog(@"Show move tile at: tile blocked: %@", NSStringFromCGPoint(position));
        }
    }
    else
    {
        NSLog(@"Show move tile at: invalid position: %@", NSStringFromCGPoint(position));
    }
}

- (void)showMoveTileAtPositionPoints:(NSArray *)positions
{
    [self removeMoveTiles];
    
    for(NSValue *pointValue in positions)
    {
        CGPoint movePoint = [pointValue CGPointValue];
        [self showMoveTileAtPositionPoint:movePoint];
    }
}

- (void)removeMoveTiles
{
    if(_moveSprites && _moveSprites.count > 0)
        for(CCSprite *moveSprite in _moveSprites) 
            [self.map removeChild:moveSprite cleanup:YES];
}

- (void)showAttackTileAtPositionPoint:(CGPoint)position
{
    if(![self isTilePosBlocked:position])
    {   
        CGPoint pos = [[self.metaLayer tileAt:position] position];
        
        pos.x += (self.map.tileSize.width / 2);
        pos.y += (self.map.tileSize.height / 2);
        
        CCSprite *attackSprite = [CCSprite spriteWithFile:@"tile_red.png"];
        [attackSprite setOpacity:128];
        [self.map addChild:attackSprite z:1];
        [_attackSprites addObject:attackSprite];
        [attackSprite setPosition:pos];
    }
    else
    {
        NSLog(@"Show attack tile at: tile blocked: %@", NSStringFromCGPoint(position));
    }
}

- (void)showAttackTileAtPositionPoints:(NSArray *)positions
{
    [self removeAttackTiles];
    
    for(NSValue *pointValue in positions)
    {
        CGPoint movePoint = [pointValue CGPointValue];
        [self showAttackTileAtPositionPoint:movePoint];
    }
}

- (void)removeAttackTiles
{
    NSLog(@"remove attack tiles");
     if(_attackSprites && _attackSprites.count > 0)
         for(CCSprite *attackSprite in _attackSprites)
             [self.map removeChild:attackSprite cleanup:YES];
}

- (void)setSprite:(CCSprite *)sprite atPositionPoint:(CGPoint)position withTag:(NSInteger)tag;
{
    if([self isLocationInBounds:position])
    {
        
        if([sprite isKindOfClass:[Unit class]]) [(Unit *)sprite setLocation:position];
        
        //NSLog(@"sprite paint at %@", NSStringFromCGPoint(position));
        
    //    CGFloat spriteWidth = sprite.contentSize.width;
    //    CGFloat spriteHeight = sprite.contentSize.height;
    //    
    //    CGFloat offsetX = 8;
    //    CGFloat offsetY = 16;
        
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
    else
    {
        NSLog(@"setSprite: invalid position");
    }
}

- (BOOL)moveSprite:(CCSprite *)sprite toTileLocation:(CGPoint)tileLocation
{
    //Tile location
    CGPoint selectedTilePoint = [self tilePosFromLocation:tileLocation tileMap:self.map];
    
    if(![self isTilePosBlocked:selectedTilePoint])
    { 
        NSLog(@"Move sprite to: %@", NSStringFromCGPoint(selectedTilePoint));
        
        CGPoint pos = [[self.metaLayer tileAt:selectedTilePoint] position];
        
        //pos.x += (self.map.mapSize.width / 2) + (self.map.tileSize.width / 2);
        //pos.y += (self.map.mapSize.height / 2) + (self.map.tileSize.height / 2);
        
        //sprite
        ccTime actualDuration = 1.0;
        
    //    CGFloat offsetX = 8;
    //    CGFloat offsetY = 16;
        
        pos.x += (self.map.tileSize.width / 2);
        pos.y += (self.map.tileSize.height / 2);
        
        pos.y -= sprite.position.y;
        pos.x -= sprite.position.x;

        // Create the actions
        id actionMove = [CCMoveBy actionWithDuration:actualDuration
                                            position:pos];

        [sprite runAction: [CCSequence actions:actionMove, nil]];
        
        if([sprite isKindOfClass:[Unit class]])
        {
            [(Unit *)sprite setLocation:selectedTilePoint];
            return YES;
        }
    }
    else
    {
        NSLog(@"moveSprite: invalid position");
    }
    
    return NO;
}

- (CGFloat)mapBoundaryX
{
    return (self.mapLayer.layerSize.width - 2);
}

- (CGFloat)mapBoundaryY
{
     return (self.mapLayer.layerSize.height - 2);
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
    
    for (CCSprite *element in self.units) 
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

- (Unit *)isFriendlyUnitWithSprite:(CCSprite *)sprite
{
    GCTurnBasedMatchHelper *gCTurnBasedMatchHelper = [GCTurnBasedMatchHelper sharedInstance];
    NSMutableArray *ownUnits = [gCTurnBasedMatchHelper playerForLocalPlayer].units;
    
    for(Unit *unit in ownUnits)
    {
        if(sprite.tag == unit.tag) return unit;
    }
    
    return nil;
}

- (Unit *)isEnemyUnitWithSprite:(CCSprite *)sprite
{
    GCTurnBasedMatchHelper *gCTurnBasedMatchHelper = [GCTurnBasedMatchHelper sharedInstance];
    NSMutableArray *enemyUnits = [gCTurnBasedMatchHelper playerForEnemyPlayer].units;
    
    for(Unit *unit in enemyUnits)
    {
        if(sprite.tag == unit.tag) return unit;
    }
    
    return  nil;
}

- (void)resetBoard
{
    [self.turn reset];
    
    for(CCSprite *sprite in self.children)
    {
        if([sprite isKindOfClass:[CCSprite class]])
        {
            //NSLog(@"remove: %@ at %@", ((Unit *)sprite).name, NSStringFromCGPoint( ((Unit *)sprite).location));
            if (sprite.tag != 1) [self removeChild:sprite cleanup:YES];
        }
    }
}

- (void)removeUnit:(Unit *)unit
{
    for(CCSprite *sprite in self.children)
    {
        if(sprite.tag == unit.tag)
        {
            NSLog(@"remove: %@ at %@", ((Unit *)sprite).name, NSStringFromCGPoint( ((Unit *)sprite).location));
            [self removeChild:sprite cleanup:YES];
        }
    }
}

- (BOOL)isEmptySquare:(CGPoint)squarePosition
{
    for(Unit *unit in self.units)
    {
        if(CGPointEqualToPoint(unit.location, squarePosition)) return NO;
    }
    
    return YES;
}

- (BOOL)isLocationInBounds:(CGPoint)location
{
    return (location.x < self.metaLayer.layerSize.width && location.y < self.metaLayer.layerSize.height && location.x >=0 && location.y >=0);
}

-(void)registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
	touchLocation = [self.map convertToNodeSpace:touchLocation];
    
    [self.currentPhase didSelectPoint:touchLocation];
    
    
//    TestPlayer *test = (TestPlayer *)[self getChildByTag:5000];
//    NSLog(@"type: %@", [self getChildByTag:5000].class);
//    [test animate];
    
//    CCSprite *sprite = (CCSprite *)[self getChildByTag:200];
//    
//    [self moveSprite:sprite toTileLocation:touchLocation];
    
    //test move
//    if(!sprite && _selectedSprite)
//    {
//        NSLog(@"move");
//        [self moveSprite:_selectedSprite toTileLocation:touchLocation];
//        _selectedSprite = nil;
//    }
//    else if (sprite) _selectedSprite = sprite;
    
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

- (void)presentMessage:(NSString *)message
{
    [self.gameViewController presentMessage:message];
    
}

- (NSArray *)units
{
    NSMutableArray *returnArray = [NSMutableArray new];
    
    GCTurnBasedMatchHelper *gCTurnBasedMatchHelper = [GCTurnBasedMatchHelper sharedInstance];
    NSMutableArray *ownUnits = [gCTurnBasedMatchHelper playerForLocalPlayer].units;
    NSMutableArray *enemyUnits = [gCTurnBasedMatchHelper playerForEnemyPlayer].units;
    
    if(ownUnits && ownUnits.count > 0) [returnArray addObjectsFromArray:ownUnits];
    if(enemyUnits && enemyUnits.count > 0) [returnArray addObjectsFromArray:enemyUnits];
    
    return returnArray;
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
