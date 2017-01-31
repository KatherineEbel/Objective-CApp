//
//  RandomRecipeResponse.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/28/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>
#import "Recipe.h"

@interface RandomRecipeResponse : MTLModel <MTLJSONSerializing>
@property NSArray<Recipe*>* recipes;
+ (NSDictionary *)parameters;
@end
