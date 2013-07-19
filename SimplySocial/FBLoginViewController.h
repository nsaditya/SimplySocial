//
//  FBLoginViewController.h
//  iOS7_Test
//
//  Created by Srinivas Nookala on 7/17/13.
//  Copyright (c) 2013 san. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBLoginViewController : UIViewController

- (IBAction)performFBLogin:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingInd;

@end
