//
//  FBLoginViewController.h
//  iOS7_Test
//
//  Created by Srinivas Nookala on 7/17/13.
//  Copyright (c) 2013 san. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FBLoginViewControllerDelegate;

@interface FBLoginViewController : UIViewController

- (IBAction)performFBLogin:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingInd;
@property (nonatomic, weak) id<FBLoginViewControllerDelegate> delegate;

@end


// 3. Definition of the delegate's interface
@protocol FBLoginViewControllerDelegate <NSObject>

- (void) openFBSession;

@end