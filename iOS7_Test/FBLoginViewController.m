//
//  FBLoginViewController.m
//  iOS7_Test
//
//  Created by Srinivas Nookala on 7/17/13.
//  Copyright (c) 2013 san. All rights reserved.
//

#import "FBLoginViewController.h"
#import "FacebookViewController.h"

@interface FBLoginViewController ()

@end

@implementation FBLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.loadingInd setHidden:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performFBLogin:(UIButton *)sender {
        [self.loadingInd setHidden:FALSE];
        [self.loadingInd startAnimating];
        
    [(FacebookViewController *)[self parentViewController] openSession];
}
@end
