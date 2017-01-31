//
//  MealCategoryController.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/30/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "MealCategoryController.h"

@interface MealCategoryController ()
@property (nonatomic, weak) IBOutlet CardCollectionViewLayout *layout;
@property (nonatomic) float animationSpeedDefault;
@end

@implementation MealCategoryController
static NSString * const reuseIdentifier = @"mealCategoryCell";
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder: aDecoder];
  if (self) {
    _viewModel = [MealCategoriesViewModel new];
  }
  return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.collectionView.scrollEnabled = false;
  [self.layout setCardSize: CGSizeMake(self.collectionView.bounds.size.width - 40, 2 * (self.collectionView.bounds.size.height / 3))];
  [self.collectionView setContentOffset: CGPointMake(0, self.navigationController.navigationBar.frame.size.height + 10)];
  [self setNumberOfCards: (int)[self.viewModel.categories count]];
  [self setAnimationSpeedDefault: 0.85];
  [self.layout setGesturesEnabled: YES];
  UINib *cellNib = [UINib nibWithNibName: @"MealCategoryCardCell" bundle:nil];
  [self.collectionView registerNib:cellNib forCellWithReuseIdentifier: reuseIdentifier];
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

- (MealCategoryCardCell *)card:(UICollectionView *)collectionView cardForItemAtIndexPath:(NSIndexPath *)indexPath {
  MealCategoryCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
  cell.layer.cornerRadius = 12;
  MealCategory *category = self.viewModel.categories[indexPath.row];
  cell.categoryNameLabel.text = category.title;
  UIImage *image = [UIImage imageNamed: category.imageName];
  cell.categoryImageView.image = image;
  return cell;
}

- (void) setAnimationSpeedDefault:(float)animationSpeedDefault {
  self.collectionView.layer.speed = animationSpeedDefault;
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

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
