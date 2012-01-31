//
//  UIView+AlertAnimations.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 20-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView(AlertAnimations)

- (void)doPopInAnimation;
- (void)doPopInAnimationWithDelegate:(id)animationDelegate;
- (void)doFadeInAnimation;
- (void)doFadeInAnimationWithDelegate:(id)animationDelegate;
- (void)doFadeOutAnimation;
- (void)doFadeOutAnimationWithDelegate:(id)animationDelegate;


@end