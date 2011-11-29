//
//  TestPlayer.h
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 11/24/11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "CCSprite.h"

@interface TestPlayer : CCSprite
{
    CGSize _size;
    NSMutableArray *_animationFrames;
}

- (id)initWithSizes:(CGSize)size;

- (void)animate;

@end
