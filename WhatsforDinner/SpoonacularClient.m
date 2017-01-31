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

@implementation SpoonacularClient
static NSString *baseURLString = @"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com";
- (RACSignal *)getRandomRecipes {
  return [self rac_GET: @"recipes/random" parameters: [RandomRecipeResponse parameters]];
}
- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
  NSURL *baseURL = [NSURL URLWithString: baseURLString];
  self = [super initWithBaseURL: baseURL sessionConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
// NSDictionary *headers = @{@"X-Mashape-Key": @"rnkimlI8Yfmshdn0Regl8sKu6YQyp1gsrUDjsnQ3vmStqvoXJQ", @"Accept": @"application/json"};
  [self.requestSerializer setValue:@"mxQWPkKjvamshBv49emHfI1wO4Fyp1hPHSQjsnma33gLBGc1iy" forHTTPHeaderField:@"X-Mashape-Key"];
  [self.requestSerializer setValue: @"application/json" forHTTPHeaderField:@"Accept"];
  return self;
}
+ (NSDictionary *)modelClassesByResourcePath {
  return @{
    @"recipes/*": [RandomRecipeResponse class]
  };
}

@end
