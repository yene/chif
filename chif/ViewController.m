//
//  ViewController.m
//  chif
//
//  Created by Yannick Weiss on 23.01.15.
//  Copyright (c) 2015 GBI. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+animatedGIF.h"

@interface ViewController () {
    BOOL NSFW;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *gif = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"http://i.imgur.com/07tFt.gif"]];
    self.imageView.image = gif;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)next:(id)sender {
}
- (IBAction)previous:(id)sender {
}
- (IBAction)save:(id)sender {
}

- (IBAction)toggleNSFW:(id)sender {
    NSFW = !NSFW;
    
    if (NSFW) {
        [sender setTitle:@"NSFW on" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"NSFW off" forState:UIControlStateNormal];
    }
}
@end
