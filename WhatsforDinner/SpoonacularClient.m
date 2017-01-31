//
//  SpoonacularClient.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/27/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpoonacularClient.h"
#import "RandomRecipeResponse.h"
#import "FoodTrivia.h"

@implementation SpoonacularClient
static NSString *baseURLString = @"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com";
- (RACSignal *)getRandomRecipesWithTags:(NSArray<NSString *> *)tags {
  return [self rac_GET: @"recipes/random" parameters: [RandomRecipeResponse parametersWithTags: tags]];
}

- (RACSignal *)getFoodTrivia {
  return [self rac_GET: @"/food/trivia/random" parameters:nil];
}
- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
  NSURL *baseURL = [NSURL URLWithString: baseURLString];
  self = [super initWithBaseURL: baseURL sessionConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
  [self.requestSerializer setValue:@"mxQWPkKjvamshBv49emHfI1wO4Fyp1hPHSQjsnma33gLBGc1iy" forHTTPHeaderField:@"X-Mashape-Key"];
  [self.requestSerializer setValue: @"application/json" forHTTPHeaderField:@"Accept"];
  return self;
}
+ (NSDictionary *)modelClassesByResourcePath {
  return @{
    @"recipes/*": [RandomRecipeResponse class],
    @"food/**" : [FoodTrivia class]
  };
}

@end
