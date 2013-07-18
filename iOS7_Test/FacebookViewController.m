//
//  DetailViewController.m
//  iOS7_Test
//
//  Created by Srinivas Nookala on 6/22/13.
//  Copyright (c) 2013 san. All rights reserved.
//

#import "FacebookViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FBLoginViewController.h"

@interface FacebookViewController ()
- (void)configureView;
@end

@implementation FacebookViewController

#pragma mark - Managing the detail item

- (void)showLoginView
{
    //UIViewController *topViewController = [self.navigationController topViewController];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //UIViewController *vc = [
    FBLoginViewController* loginViewController = [sb instantiateViewControllerWithIdentifier:@"FBLoginControllerID"];

    //[[FBLoginViewController alloc]initWithNibName:@"FBLoginViewController" bundle:nil];
    [self presentViewController:loginViewController animated:NO completion:nil];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    // See if the app has a valid token for the current state.
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // To-do, show logged in view
    } else {
        // No, display the login page.
        [self showLoginView];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            UIViewController *topViewController =
            [self.navigationController topViewController];
            if ([[topViewController presentedViewController]
                 isKindOfClass:[FBLoginViewController class]]) {
                [topViewController dismissViewControllerAnimated:NO completion:nil];
            }
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
            [self showLoginView];
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    NSLog(@"Inside FacebookViewController:openSession");
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

@end
