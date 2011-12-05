//
//  GameViewController.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 22-11-11.
//  Copyright Pro4all 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;


@interface GameViewController : UIViewController {

}

@property (retain, nonatomic) IBOutlet UILabel *playerOneLabel;
@property (retain, nonatomic) IBOutlet UILabel *playerTwoLabel;

- (void)updateLabels;

@end
