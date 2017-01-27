//
//  ViewController.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/21/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodTrivia.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *foodTriviaLabel;
@property FoodTrivia *foodTrivia;

@end

