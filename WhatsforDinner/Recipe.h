//
//  Recipe.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/21/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface Recipe : NSObject

@property int idNumber;
@property NSString *imageURL;
@property NSString *sourceURL;
@property NSString *title;
@property NSString *readyInMinutes;
@property NSString *instructions;
@property int cookingMinutes;
+ (RKObjectMapping *)mapping;
 
@end
