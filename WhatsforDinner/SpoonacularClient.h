//
//  SpoonacularClient.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/27/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Overcoat/OvercoatReactiveCocoa/OvercoatReactiveCocoa.h>
// Get randomRecipes params:
// limitLicense (bool)
// number (int)
// tags (string) - commma separated
@interface SpoonacularClient : OVCHTTPSessionManager
+ (NSDictionary *)modelClassesByResourcePath;
- (RACSignal *)getFoodTrivia;
- (RACSignal *)getRandomRecipesWithTags:(NSArray<NSString *> *)tags;
@end
