//
//  RecipeCardStackViewController.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/22/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "RecipeCardStackViewController.h"
#import "CardCollectionCell.h"
#import "UIViewController+ViewControllerErrorAlert.h"


@interface RecipeCardStackViewController () {
}
@property (weak, nonatomic) IBOutlet CardCollectionViewLayout *layout;
@property (nonatomic) float animationSpeedDefault;
@end

@implementation RecipeCardStackViewController
static NSString * const reuseIdentifier = @"recipeCardCell";

- (void)viewDidLoad {
  [super viewDidLoad];
  self.collectionView.scrollEnabled = false;
  [self setNumberOfCards: (int)[self.viewModel.randomRecipes count]];
  [self setAnimationSpeedDefault: 0.85];
  [self.layout setGesturesEnabled: YES];
  UINib *cellNib = [UINib nibWithNibName: @"RecipeCardCell" bundle:nil];
  [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:reuseIdentifier];
  @weakify(self);
  RACSignal *recipesSignal = [RACObserve(self.viewModel, randomRecipes) subscribeOn: [RACScheduler mainThreadScheduler]];
  [[recipesSignal
    skip:1]
    subscribeNext:^(NSArray *recipes) {
      @strongify(self);
      self.numberOfCards = (int)[recipes count];
      [self.collectionView reloadData];
  }];
  RACSignal *errorSignal = [RACObserve(self.viewModel, errorMessage) subscribeOn: [RACScheduler mainThreadScheduler]];
  [[errorSignal
    skip: 1]
    subscribeNext:^(NSString *errorMessage) {
      @strongify(self);
      NSLog(@"%@", errorMessage);
      if (![self presentedViewController]) {
        [self alertForError: errorMessage];
      }
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) newCardWasAdded {
  if (_layout.newCardShouldAppearOnBottom) {
    [_layout handleAddingNewCard: _numberOfCards - 1];
  } else {
    [_layout handleAddingNewCard: 0];
  }
}
- (RecipeCardCell *)card:(UICollectionView *)collectionView cardForItemAtIndexPath:(NSIndexPath *)indexPath {
  RecipeCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
  cell.layer.cornerRadius = 12;
  [cell setRecipe: self.viewModel.randomRecipes[indexPath.row]];
  return cell;
}

- (void) setAnimationSpeedDefault:(float)animationSpeedDefault {
  self.collectionView.layer.speed = animationSpeedDefault;
}

- (void)show:(Recipe *)recipe {
  SFSafariViewController *controller = [[SFSafariViewController alloc] initWithURL:recipe.sourceURL entersReaderIfAvailable:true];
  [self presentViewController:controller animated:true completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _numberOfCards;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  return [self card: collectionView cardForItemAtIndexPath: indexPath];
}

#pragma mark <UICollectionViewDataSource>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  Recipe *recipe = self.viewModel.randomRecipes[indexPath.row];
  [self show:recipe];
}
@end
