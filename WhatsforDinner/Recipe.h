//
//  Recipe.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/21/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>

@interface Recipe : MTLModel <MTLJSONSerializing>

@property NSNumber *recipeID;
@property NSNumber *preparationMinutes;
@property NSNumber *readyInMinutes;
@property NSNumber *cookingMinutes;
@property NSURL *imageURL;
@property NSURL *sourceURL;
@property NSString *title;
@property NSString *instructions;
@property NSString *creditText;

@end
