//
//  DetailViewController.h
//  iOS7_Test
//
//  Created by Srinivas Nookala on 6/22/13.
//  Copyright (c) 2013 san. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FBLoginViewController.h"

@interface FacebookViewController : UIViewController <FBLoginViewControllerDelegate>
@property (weak, nonatomic) IBOutlet FBProfilePictureView *fbProfileImage;

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *fbUserName;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *fbUserStatus;

@end
