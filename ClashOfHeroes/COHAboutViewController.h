//
//  COHAboutViewController.h
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 2/1/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <UIKit/UIKit.h>

@class COHAboutViewController;

@protocol COHAboutViewControllerDelegate

@required

- (void)aboutView:(COHAboutViewController *)about wasDismissedWithButtonIndex:(NSInteger)buttonIndex;

@optional

- (void)aboutViewWasCancelled:(COHAboutViewController *)about;

@end

@interface COHAboutViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (retain, nonatomic) IBOutlet UIView *aboutView;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UITextView *textView;
@property (retain, nonatomic) id<COHAboutViewControllerDelegate> delegate;
@property (nonatomic, assign) NSInteger tag;

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message forView:(UIView *)view;
- (void)show;
- (IBAction)okButtonPressed:(id)sender;
- (IBAction)feedbackButtonPressed:(id)sender;

@end
