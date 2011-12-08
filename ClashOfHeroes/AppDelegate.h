//
//  AppDelegate.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 22-11-11.
//  Copyright Pro4all 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainMenuViewController, GameViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	MainMenuViewController	*viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
