//
//  FoodTrivaViewModel.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/31/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "FoodTrivaViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Overcoat/Overcoat.h>
#import <ReactiveCocoa/RACEXTScope.h>
@implementation FoodTrivaViewModel
- (instancetype)init {
  _client = [SpoonacularClient new];
//  @weakify(self)
//  [[[self.client getFoodTrivia]
//    take: 1]
//    subscribeNext:^(OVCResponse *response) {
//      @strongify(self)
//      self.trivia = response.result;
//    } error:^(NSError *error) {
//      OVCResponse *response = error.userInfo[@"OVCResponse"];
//      NSLog(@"%@", response.result);
//      @strongify(self)
//      self.errorMessage = response.result[@"message"];
//  }];
  return self;
}
@end
