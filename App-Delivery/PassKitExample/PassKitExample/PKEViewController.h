//
//  PKEViewController.h
//  PassKitExample
//
//  Created by Keith Moon on 24/03/2013.
//  Copyright (c) 2013 Passbook Example Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PassKit/PassKit.h>

@interface PKEViewController : UIViewController <PKAddPassesViewControllerDelegate>

@property (nonatomic, retain) IBOutlet UIButton *addPassButton;

- (IBAction)addPassButtonPressed:(id)sender;

@end
