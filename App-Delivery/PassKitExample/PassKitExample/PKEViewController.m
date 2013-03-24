//
//  PKEViewController.m
//  PassKitExample
//
//  Created by Keith Moon on 24/03/2013.
//  Copyright (c) 2013 Passbook Example Company. All rights reserved.
//

#import "PKEViewController.h"

@interface PKEViewController ()

@property (nonatomic, retain) PKPass *genericPass;

@end

@implementation PKEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Create the PKPass from the bundled file
    // In a real App this may be retrive from the network.
    
    NSString *passFilePath = [[NSBundle mainBundle] pathForResource:@"Pass-Example-Generic" ofType:@"pkpass"];
    NSData *passData = [[NSData alloc] initWithContentsOfFile:passFilePath];
    NSError *passError;
    _genericPass = [[PKPass alloc] initWithData:passData error:&passError];
    [passData release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_addPassButton release];
    [_genericPass release];
    
    [super dealloc];
}

#pragma mark - IBAction Methods

- (IBAction)addPassButtonPressed:(id)sender {
    
    if (![PKPassLibrary isPassLibraryAvailable]) {
        
        NSLog(@"Passbook not available on this device");
        return;
        
    }
    
    PKAddPassesViewController *addPassViewController = [[PKAddPassesViewController alloc] initWithPass:self.genericPass];
    addPassViewController.delegate = self;
    
    [self presentViewController:addPassViewController animated:YES completion:^{
        
        NSLog(@"Add Pass view controller presented");
        
    }];
    
    [addPassViewController release];
}

#pragma mark - PKAddPassesViewControllerDelegate Methods

- (void)addPassesViewControllerDidFinish:(PKAddPassesViewController *)controller {
    
    // Check if the Pass is now in the Pass Library
    
    PKPassLibrary *passLibrary = [[PKPassLibrary alloc] init];
    
    if ([passLibrary containsPass:self.genericPass]) {
        
        // If the Pass is now in the Library, we can't re-add it, only view it.
        [self.addPassButton setTitle:@"View Pass in Passbook" forState:UIControlStateNormal];
        
    } 
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSLog(@"Add Pass view controller dismissed");
        
    }];
    
}

@end
