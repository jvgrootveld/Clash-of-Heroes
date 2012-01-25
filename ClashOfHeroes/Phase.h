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

- (void)didSelectPoint:(CGPoint)point onLayer:(GameLayer *)layer;
- (void)endPhaseOnLayer:(GameLayer *)layer;

@end
