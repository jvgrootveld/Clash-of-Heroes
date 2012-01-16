//
//  Match.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 09-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;

@interface Match : NSObject


@property (nonatomic, strong) NSMutableArray *players;

- (void)addPlayer:(Player *)player;

@end
