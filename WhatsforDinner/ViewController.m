//
//  ViewController.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/21/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "ViewController.h"
#import "SpoonacularClient.h"
#import "RandomRecipeResponse.h"
#import <ReactiveCocoa/RACSignal.h>
#import <Overcoat/OVCResponse.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
//  [self loadRecipes];
}

- (void)viewDidAppear:(BOOL)animated {
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (void)loadRecipes {
// NSDictionary *headers = @{@"X-Mashape-Key": @"rnkimlI8Yfmshdn0Regl8sKu6YQyp1gsrUDjsnQ3vmStqvoXJQ", @"Accept": @"application/json"};
  self.client = [[SpoonacularClient alloc] initWithBaseURL:nil sessionConfiguration:nil];
  [[self.client getRandomRecipes] subscribeNext:^(OVCResponse *response) {
    NSLog(@"%@", response.result);
  } error:^(NSError *error) {
    NSLog(@"\n%@\n%@\n%@", error.localizedFailureReason, error.localizedRecoverySuggestion, error.localizedRecoveryOptions);
  }];
}
@end
