//
//  DetailViewController.h
//  iOS7_Test
//
//  Created by Srinivas Nookala on 6/22/13.
//  Copyright (c) 2013 san. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacebookViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

- (void)openSession;

@end
