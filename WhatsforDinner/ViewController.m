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
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Overcoat/OVCResponse.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "UIViewController+ViewControllerErrorAlert.h"
@interface ViewController ()

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder: aDecoder];
  if (self) {
    _viewModel = [FoodTrivaViewModel new];
  }
  return self;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  @weakify(self);
  RACSignal *trivaSignal = [RACObserve(self.viewModel, trivia) subscribeOn: [RACScheduler mainThreadScheduler]];
  [trivaSignal subscribeNext:^(FoodTrivia *foodTrivia) {
    @strongify(self);
    self.foodTriviaLabel.text = foodTrivia.text;
  }];
  RACSignal *errorSignal = [RACObserve(self.viewModel, clientError) subscribeOn: [RACScheduler mainThreadScheduler]];
  [errorSignal subscribeNext:^(NSError *error) {
    @strongify(self);
    [self alertForError: error.localizedDescription];
  }];
  
}

- (void)viewWillAppear:(BOOL)animated {
  [self loadFoodTrivia];
}

- (void)viewDidAppear:(BOOL)animated {
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)loadFoodTrivia {
  
}


@end
