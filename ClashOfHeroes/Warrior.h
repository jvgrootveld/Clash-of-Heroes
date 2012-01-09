//
//  Warrior.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "Unit.h"

@interface Warrior : Unit

- (id)initForPlayer:(Player *)player withTag:(NSInteger)tag;

@end
