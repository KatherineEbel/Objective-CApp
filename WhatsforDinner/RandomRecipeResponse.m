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
