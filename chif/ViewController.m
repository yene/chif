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
    NSUInteger position;
    NSArray *results;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *gifsJSON = [self gifsJSON];
    results = [gifsJSON valueForKeyPath:@"data.children"];
    for (NSDictionary *entries in results) {
        position++;
        
        NSDictionary *theGOODStuff = [entries valueForKey:@"data"];
        if ([[theGOODStuff valueForKey:@"over_18"] boolValue] && !NSFW) continue;
        
        UIImage *gif = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:[theGOODStuff valueForKey:@"url"]]];
        self.imageView.image = gif;
        break;
    }
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

- (NSDictionary *)gifsJSON {
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.reddit.com/r/gifs.json"]];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

@end
