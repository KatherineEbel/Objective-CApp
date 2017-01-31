//
//  RecipeCardStackViewController.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/22/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "RecipeCardStackViewController.h"
#import "CardCollectionCell.h"

@interface RecipeCardStackViewController () {
  NSArray *cardColors;
}
@property (weak, nonatomic) IBOutlet CardCollectionViewLayout *layout;
@property (nonatomic) float animationSpeedDefault;
@end

@implementation RecipeCardStackViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  cardColors = @[[UIColor cyanColor], [UIColor magentaColor],
        [UIColor purpleColor], [UIColor blueColor], [UIColor greenColor]];
  self.collectionView.scrollEnabled = false;
  [self setNumberOfCards: 6];
  [self setAnimationSpeedDefault: 0.85];
  [self.layout setGesturesEnabled: YES];
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
- (CardCollectionCell *)card:(UICollectionView *)collectionView cardForItemAtIndexPath:(NSIndexPath *)indexPath {
  CardCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cardCell" forIndexPath:indexPath];
  cell.layer.cornerRadius = 12;
  cell.backgroundColor = cardColors[indexPath.item % [cardColors count]];
  return cell;
}

- (void) setAnimationSpeedDefault:(float)animationSpeedDefault {
  self.collectionView.layer.speed = animationSpeedDefault;
}

- (void)loadRecipes {
// NSDictionary *headers = @{@"X-Mashape-Key": @"rnkimlI8Yfmshdn0Regl8sKu6YQyp1gsrUDjsnQ3vmStqvoXJQ", @"Accept": @"application/json"};
//  self.client = [[SpoonacularClient alloc] initWithBaseURL:nil sessionConfiguration:nil];
//  [[self.client getRandomRecipes] subscribeNext:^(OVCResponse *response) {
//    NSLog(@"%@", response.result);
//  } error:^(NSError *error) {
//    NSLog(@"\n%@\n%@\n%@", error.localizedFailureReason, error.localizedRecoverySuggestion, error.localizedRecoveryOptions);
//  }];
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

@end
