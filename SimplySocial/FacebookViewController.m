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
    loginViewController.delegate = self;
    //[[FBLoginViewController alloc]initWithNibName:@"FBLoginViewController" bundle:nil];
    [self presentViewController:loginViewController animated:NO completion:nil];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    // See if the app has a valid token for the current state.
    NSLog(FBSession.activeSession.debugDescription);
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // To-do, show logged in view
        NSLog(@"FB session status is FBSessionStateCreatedTokenLoaded");
        
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
    UIViewController *topViewController =
    [self.navigationController topViewController];
    switch (state) {
        case FBSessionStateOpen: {
            NSLog(@"FB Session state is Open");
            
            if ([[topViewController presentedViewController]
                 isKindOfClass:[FBLoginViewController class]]) {
                [topViewController dismissViewControllerAnimated:NO completion:nil];
            }
        }
            break;
        case FBSessionStateClosed:
                        NSLog(@"FB Session state is Closed");
        case FBSessionStateClosedLoginFailed:
                        NSLog(@"FB Session state is ClosedLoginFailed");
            // Once the user has logged in, we want them to
            // be looking at the root view.
            if ([[topViewController presentedViewController]
                 isKindOfClass:[FBLoginViewController class]]) {
                [topViewController dismissViewControllerAnimated:NO completion:nil];
            }
            //[self.navigationController popToRootViewControllerAnimated:NO];
            
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

- (void)openFBSession
{
    NSLog(@"Inside FacebookViewController:openSession");
    NSArray *readPermissions =
    [NSArray arrayWithObjects:@"email", @"user_photos", @"friends_photos", @"user_about_me", @"friends_about_me", @"user_activities", @"friends_activities",@"user_birthday",@"friends_birthday",@"user_checkins",@"friends_checkins",@"user_education_history",@"friends_education_history",@"friends_events",@"user_events",@"user_groups",@"friends_groups",@"user_hometown",@"friends_hometown",@"user_interests",@"friends_interests",@"user_likes",@"friends_likes",@"user_notes",@"friends_notes",@"user_online_presence",@"friends_online_presence",@"user_interests",@"friends_interests",@"user_likes",@"friends_likes",@"user_religion_politics",@"friends_religion_politics",@"user_status",@"friends_status",@"user_subscriptions",@"friends_subscriptions",@"user_videos",@"friends_videos",@"user_website",@"friends_website",@"user_work_history",@"friends_work_history",@"read_friendlists",@"read_mailbox",@"read_requests",@"read_stream",@"read_insights",@"xmpp_login", nil];
    
    
    
    [FBSession openActiveSessionWithReadPermissions:readPermissions
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

@end
