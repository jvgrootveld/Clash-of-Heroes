//
//  CDPlayer.h
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 1/29/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDPlayer : NSManagedObject

@property (nonatomic, retain) NSString *gameCenterId;
@property (nonatomic, retain) NSManagedObject *stats;

@end
