//
//  ViewController.h
//  chif
//
//  Created by Yannick Weiss on 23.01.15.
//  Copyright (c) 2015 GBI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLAnimatedImageView;

@interface ViewController : UIViewController
- (IBAction)previous:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *previous;

- (IBAction)next:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *next;

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *gifView;

- (IBAction)save:(id)sender;

- (IBAction)toggleNSFW:(id)sender;


@end

