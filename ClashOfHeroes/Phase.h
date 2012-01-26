//
//  Phase.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 16-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameLayer;

@protocol Phase <NSObject>

@property (nonatomic) NSInteger remainingMoves;
@property (nonatomic, strong) GameLayer *gameLayer;

- (id)initWithGameLayer:(GameLayer *)gameLayer;
- (void)didSelectPoint:(CGPoint)point;
- (void)endPhase;

@end
