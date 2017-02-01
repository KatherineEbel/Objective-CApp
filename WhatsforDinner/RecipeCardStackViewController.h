//
//  RecipeCardStackViewController.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/22/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>
#import "CardCollectionViewLayout.h"
#import "CardCollectionCell.h"
#import "CardStackCollectionViewDelegate.h"
#import "RecipeViewModel.h"
#import "RecipeCardCell.h"
@interface RecipeCardStackViewController: UICollectionViewController <SFSafariViewControllerDelegate>
@property (nonatomic) int numberOfCards;
@property (nonatomic,strong) RecipeViewModel *viewModel;
- (RecipeCardCell *)card:(UICollectionView *)collectionView cardForItemAtIndexPath:(NSIndexPath *)indexPath;
@end
