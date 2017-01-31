//
//  MealCategory.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/26/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "MealCategory.h"

@implementation MealCategory
- (instancetype)initWithDict:(NSDictionary<NSString *,NSString *> *)dict {
  _title = dict[@"category"];
  _imageName = dict[@"imageName"];
  return self;
}
@end
