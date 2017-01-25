//
//  Recipe.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/21/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//
#import "Recipe.h"

@implementation Recipe
+ (RKObjectMapping *)mapping {
  static RKObjectMapping *mapping = nil;
  if (mapping == nil) {
    mapping = [RKObjectMapping mappingForClass:[Recipe class]];
  }
  return mapping;
}
@end
