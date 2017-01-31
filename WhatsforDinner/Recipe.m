//
//  Recipe.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/21/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//
#import "Recipe.h"
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

//@property int recipeID;
//@property NSString *image;
//@property NSString *sourceURL;
//@property NSString *title;
//@property NSString *preparationMinutes;
//@property NSString *readyInMinutes;
//@property NSString *instructions;
//@property NSString *creditText;
//@property int cookingMinutes;
@implementation Recipe
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"recipeID": @"id",
           @"imageURL": @"image",
           @"sourceURL": @"sourceUrl",
           @"title": @"title",
           @"preparationMinutes": @"preparationMinutes",
           @"cookingMinutes": @"cookingMinutes",
           @"readyInMinutes": @"readyInMinutes",
           @"instructions": @"instructions",
           @"creditText": @"creditText"
           };
}

+ (NSValueTransformer *)imageURLJSONTransformer {
  // use built-in "value transformer to convert strings int NSURL
  return [NSValueTransformer valueTransformerForName: MTLURLValueTransformerName];
}

+ (NSValueTransformer *)sourceURLJSONTransformer {
  return [NSValueTransformer valueTransformerForName: MTLURLValueTransformerName];
}


@end
