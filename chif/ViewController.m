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
    NSMutableArray *gifs;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    gifs = [NSMutableArray array];
    [self loadGifs];
    [self displayGif];
}

- (void)loadGifs {
    position = 0;
    NSDictionary *gifsJSON = [self gifsJSON];
    NSArray *results = [gifsJSON valueForKeyPath:@"data.children"];
    [gifs removeAllObjects];
    for (NSDictionary *entries in results) {
        NSDictionary *theGOODStuff = [entries valueForKey:@"data"];
        if ([[theGOODStuff valueForKey:@"over_18"] boolValue] && !NSFW) continue;
        [gifs addObject:[NSURL URLWithString:[theGOODStuff valueForKey:@"url"]]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)next:(id)sender {
    [self nextGif];
}
- (IBAction)previous:(id)sender {
    [self previousGif];
}
- (IBAction)save:(id)sender {
    //yolo
}

- (IBAction)toggleNSFW:(id)sender {
    NSFW = !NSFW;
    
    if (NSFW) {
        [sender setTitle:@"NSFW on" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"NSFW off" forState:UIControlStateNormal];
    }
    [self loadGifs];
}

- (void)nextGif {
    position++;
    if (position == [gifs count]) position = 0;
    [self displayGif];
}

- (void)previousGif {
    position--;
    if (position == 0) position = [gifs count];
    [self displayGif];
}

- (void)displayGif {
    UIImage *gif = [UIImage animatedImageWithAnimatedGIFURL:gifs[position]];
    self.imageView.image = gif;
}

- (NSDictionary *)gifsJSON {
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.reddit.com/r/gifs.json"]];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

@end
