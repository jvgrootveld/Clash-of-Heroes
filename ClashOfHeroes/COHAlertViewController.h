//
//  COHAlertViewController.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 20-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <UIKit/UIKit.h>

@class COHAlertViewController;

@protocol COHAlertViewDelegate

@required

- (void)alertView:(COHAlertViewController *)alert wasDismissedWithButtonIndex:(NSInteger)buttonIndex;

@optional

- (void)alertViewWasCancelled:(COHAlertViewController *)alert;

@end

@interface COHAlertViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (retain, nonatomic) IBOutlet UIView *alertView;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *messageLabel;
@property (retain, nonatomic) id<COHAlertViewDelegate> delegate;
@property (nonatomic, assign) NSInteger tag;

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message;
- (void)show;
- (IBAction)dismiss:(id)sender;

@end
