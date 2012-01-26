//
//  MatchData.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 26-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;

@interface MatchData : NSObject

@property (nonatomic, strong) Player *playerOne;
@property (nonatomic, strong) Player *playerTwo;

- (NSDictionary *)toDictionary;

@end
