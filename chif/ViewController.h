//
//  ViewController.h
//  chif
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@class FLAnimatedImageView;

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate>
- (IBAction)previous:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *previous;

- (IBAction)next:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *next;

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *gifView;

- (IBAction)save:(id)sender;

- (IBAction)toggleNSFW:(id)sender;

- (IBAction)share:(id)sender;

@end

