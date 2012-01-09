//
//  BoardFactory.h
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 1/9/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;

@protocol BoardFactory <NSObject>

+ (void)createBoardOnLayer:(CCLayer *)layer withPlayer1:(Player *)player1 andPlayer2:(Player *)player2;

@end
