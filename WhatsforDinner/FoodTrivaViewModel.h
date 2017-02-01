//
//  FoodTrivaViewModel.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/31/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodTrivia.h"
#import "SpoonacularClient.h"

@interface FoodTrivaViewModel : NSObject
@property (nonatomic, strong) SpoonacularClient *client;
@property (nonatomic, strong) FoodTrivia *trivia;
@property (nonatomic, strong) NSString *errorMessage;
@end
