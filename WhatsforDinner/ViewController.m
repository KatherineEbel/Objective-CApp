//
//  ViewController.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/21/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "Recipe.h"
#import <RestKit/RestKit.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [self configureRestKit];
  [self loadFoodTrivia];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)configureRestKit {
  NSURL *baseURL = [NSURL URLWithString: @"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com"];
  AFRKHTTPClient * client = [[AFRKHTTPClient alloc] initWithBaseURL:baseURL];
  [client setDefaultHeader:@"X-Mashape-Key" value: @"mxQWPkKjvamshBv49emHfI1wO4Fyp1hPHSQjsnma33gLBGc1iy"];
  [client setDefaultHeader:@"Accept" value: @"application/json"];
  RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient: client];
  RKObjectMapping *triviaMapping = [RKObjectMapping mappingForClass:[FoodTrivia class]];
  RKObjectMapping *recipeMapping = [RKObjectMapping mappingForClass:[Recipe class]];
  
  [triviaMapping addAttributeMappingsFromArray: @[@"text"]];
  RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor
                                              responseDescriptorWithMapping: triviaMapping
                                              method:RKRequestMethodGET
                                              pathPattern:@"/food/trivia/random"
                                              keyPath: nil
                                              statusCodes:[NSIndexSet indexSetWithIndex:200]];
//  [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"]; 
  [objectManager addResponseDescriptor:responseDescriptor];
}

- (void)loadFoodTrivia {
  [[RKObjectManager sharedManager] getObjectsAtPath: @"/food/trivia/random" parameters: nil
    success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
      NSLog(@"%@", mappingResult.firstObject);
      _foodTrivia = mappingResult.firstObject;
      _foodTriviaLabel.text = _foodTrivia.text;
    }
    failure:^(RKObjectRequestOperation *operation, NSError *error) {
      NSLog(@"No recipes: %@", error);
    }];
}

- (void)loadRecipes {
// NSDictionary *headers = @{@"X-Mashape-Key": @"rnkimlI8Yfmshdn0Regl8sKu6YQyp1gsrUDjsnQ3vmStqvoXJQ", @"Accept": @"application/json"};
}

@end
