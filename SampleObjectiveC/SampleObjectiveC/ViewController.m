//
//  ViewController.m
//  SampleObjectiveC
//
//  Created by ichise on 2017/07/31.
//

#import "ViewController.h"
@import FormSheetTextView;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)click:(id)sender {
    __weak FormSheetTextViewController *formSheetTextViewController = [FormSheetTextViewController instantiate];
    [formSheetTextViewController setWithInitialText:@"initial text"];
    [formSheetTextViewController setWithTitleText:@"Title"];
    [formSheetTextViewController setWithCancelButtonText:@"Cancel"];
    [formSheetTextViewController setWithSendButtonText:@"Send"];
    [formSheetTextViewController setCompletionHandler:^(NSString *sendText) {
        
        if ([sendText length] > 20) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"The number of characters exceeds the upper limit. Please enter within 20 characters." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
            [alertController addAction:cancelAction];
            [formSheetTextViewController presentViewController:alertController animated:YES completion:nil];

            return;
        }
        
        if ([sendText length] == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"It is not input. Please enter.." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
            [alertController addAction:cancelAction];
            [formSheetTextViewController presentViewController:alertController animated:YES completion:nil];
            
            return;
        }
        
        [formSheetTextViewController dismissViewControllerAnimated:true completion:nil];
    }];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:formSheetTextViewController];
    [navigationController setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:navigationController animated:true completion:nil];
}

@end
