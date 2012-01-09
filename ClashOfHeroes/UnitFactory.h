//
//  PieceFactory.h
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 1/9/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Unit;
@class Player;

@protocol UnitFactory <NSObject>

+ (Unit *)createUnitWithTag:(NSInteger)tag forPlayer:(Player *)player;

@end
