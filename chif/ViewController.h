//
//  ViewController.h
//  chif
//
//  Created by Yannick Weiss on 23.01.15.
//  Copyright (c) 2015 GBI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)previous:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *previous;

- (IBAction)next:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *next;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)save:(id)sender;

- (IBAction)toggleNSFW:(id)sender;


@end

