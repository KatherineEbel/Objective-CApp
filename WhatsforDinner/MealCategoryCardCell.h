//
//  MealCategoryCardCell.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/30/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "CardCollectionCell.h"

@interface MealCategoryCardCell : CardCollectionCell
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;

@end
