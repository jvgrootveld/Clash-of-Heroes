//
//  TestPlayer.m
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 11/24/11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "TestPlayer.h"

@implementation TestPlayer

- (id)initWithSizes:(CGSize)size
{
    if(self = [super init])
    {
        _size = size;
        
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:@"grossini_dance_atlas.png"];

		// manually add frames to the frame cache
        _animationFrames = [NSMutableArray array];
        
        for(int i = 0; i < 4; i++)
        {
            CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:texture rect:CGRectMake( _size.width*i,  _size.height*0, _size.width, _size.height)];
            [_animationFrames addObject:frame];
        }
        
        self = [CCSprite spriteWithSpriteFrame:[_animationFrames objectAtIndex:0]];
    }
    return self;
}

- (void)animate
{
    CCAnimation *animation = [CCAnimation animationWithFrames:_animationFrames delay:0.2f];
    CCAnimate *animate = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
    CCSequence *seq = [CCSequence actions: animate,
                       [CCFlipX actionWithFlipX:YES],
                       [[animate copy] autorelease],
                       [CCFlipX actionWithFlipX:NO],
                       nil];
    
    [self runAction:[CCRepeatForever actionWithAction: seq ]];
}

@end
