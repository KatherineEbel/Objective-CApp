//
//  FoodTrivaViewModel.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/31/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "FoodTrivaViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Overcoat/OVCResponse.h>
#import <ReactiveCocoa/RACEXTScope.h>
@implementation FoodTrivaViewModel
- (instancetype)init {
  _client = [SpoonacularClient new];
  
  [[[self.client getFoodTrivia]
    take: 1]
    subscribeNext:^(OVCResponse *response) {
      self.trivia = response.result;
    } error:^(NSError *error) {
      self.clientError = error;
      NSLog(@"%@", self.clientError.localizedDescription);
  }];
  return self;
}
@end

//  [[self.client getRandomRecipes] subscribeNext:^(OVCResponse *response) {
//    NSLog(@"%@", response.result);
//  } error:^(NSError *error) {
//    NSLog(@"\n%@\n%@\n%@", error.localizedFailureReason, error.localizedRecoverySuggestion, error.localizedRecoveryOptions);
//  }];
