//
//  RandomRecipeResponse.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/28/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "RandomRecipeResponse.h"
#import "Recipe.h"
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@implementation RandomRecipeResponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{ @"recipes" : @"recipes" };
}

// spoonacular api takes comma separated list of 'tags' to focus on recipes for those values
// take given array of strings, and convert that to comma separated list. All lists should include
// main course tag, since this is an app for finding dinner recipes
+ (NSDictionary *)parametersWithTags:(NSArray<NSString*> *)tags {
  NSString *tagsString = [tags componentsJoinedByString: @","];
  NSString *tagsWithMainCourse = [tagsString stringByAppendingString: @",main course"];
  return @{
           @"limitLicense"  : @"true",
           @"number"       : @"1",
           @"tags"         : tagsWithMainCourse
           };
}

+ (NSValueTransformer *)recipesJSONTransformer {
  // tell Mantle to populate recipes with an array of Recipe objects
  return [MTLJSONAdapter arrayTransformerWithModelClass:[Recipe class]];
}
@end
