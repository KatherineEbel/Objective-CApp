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

// Initializes a AFHTTPSessionManager
- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
  NSURL *baseURL = [NSURL URLWithString: baseURLString];
  self = [super
          initWithBaseURL: baseURL
          sessionConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
  [self.requestSerializer
   setValue:@"mxQWPkKjvamshBv49emHfI1wO4Fyp1hPHSQjsnma33gLBGc1iy"
   forHTTPHeaderField:@"X-Mashape-Key"];
  [self.requestSerializer
   setValue: @"application/json"
   forHTTPHeaderField:@"Accept"];
  return self;
}

// returns a signal that will immediately fetch random recipes given an array of strings
// the RandomRecipeResponse class knows how to parse the array with values it can use to create request.
- (RACSignal *)getRandomRecipesWithTags:(NSArray<NSString *> *)tags {
  return [self
          rac_GET: @"recipes/random"
          parameters: [RandomRecipeResponse parametersWithTags: tags]];
}

// returns signal that will immediately fetch a single foodtrivia object
- (RACSignal *)getFoodTrivia {
  return [self rac_GET: @"/food/trivia/random" parameters:nil];
}

// MARK: - map models to a path (** maps any number of path components that starts with beginning path
+ (NSDictionary *)modelClassesByResourcePath {
  return @{
    @"recipes/*": [RandomRecipeResponse class],
    @"food/**" : [FoodTrivia class]
  };
}

@end
