//
//  MealCategory.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/26/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MealCategory : NSObject
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *imageName;
- (instancetype)initWithDict:(NSDictionary<NSString*,NSString*>*)dict;
@end
