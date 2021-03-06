//
//  ViewController.m
//  chif
//

#import "ViewController.h"
#import "FLAnimatedImage.h"


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
    NSMutableArray *saved = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"saved"]];
    [saved addObject:[gifs[position] absoluteString]];
    [[NSUserDefaults standardUserDefaults] setObject:saved forKey:@"saved"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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

- (IBAction)share:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        NSArray *saved = [[NSUserDefaults standardUserDefaults] arrayForKey:@"saved"];
        NSString *gifList = [saved componentsJoinedByString:@"\n"];
        
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"GIFS I LOVE"];
        [mail setMessageBody:gifList isHTML:NO];
        [self presentViewController:mail animated:YES completion:NULL];
    }
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
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(135,140,50,50)];
    [spinner startAnimating];
    [self.gifView addSubview:spinner];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:gifs[position]]];
        self.gifView.animatedImage = image;
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner removeFromSuperview];
        });
    });
}

- (NSDictionary *)gifsJSON {
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.reddit.com/r/gifs.json"]];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate methods
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
