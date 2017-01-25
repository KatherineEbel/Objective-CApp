//
//  CardCollectionViewLayout.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/22/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "CardCollectionViewLayout.h"
#import "CardCollectionCell.h"
@interface CardCollectionViewLayout ()
{
  NSIndexPath *_indexPathOfDraggedCell;
  CGPoint _initialCellCenter;
  NSMutableDictionary *_bottomStackRotations;
  BOOL _newCardAnimatonInProgress;
  double _coefficientOfrotation;
  CGFloat _angleOfRotationForNewCardAnimation;
  CGFloat _verticalOffsetBetweenCardsInTopStack;
  CGFloat _centralCardYPosition;
}

@end

@implementation CardCollectionViewLayout
- (void)setIndex:(int)index {
  _indexPathOfDraggedCell = _index > index ? [NSIndexPath indexPathForItem: index inSection:0] : [NSIndexPath indexPathForItem: _index inSection:0];
  UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath: _indexPathOfDraggedCell];
  if (cell != nil) {
    [self.collectionView bringSubviewToFront: cell];
  }
  
  [self.collectionView performBatchUpdates:^{
    [self invalidateLayout];
  } completion:^(BOOL finished) {
    // TODO: tell delegate cardDidChange state
  }];
}
- (void)prepareLayout {
  [super prepareLayout];
  [self setDefaultValues];
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
  [super initialLayoutAttributesForAppearingItemAtIndexPath: itemIndexPath];
  UICollectionViewLayoutAttributes *initialAttributes;
  if (((_newCardShouldAppearOnBottom && itemIndexPath.item == [self.collectionView numberOfItemsInSection: 0] - 1) || (!_newCardShouldAppearOnBottom && itemIndexPath.item == 0)) && _newCardAnimatonInProgress) {
    initialAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath: itemIndexPath];
    CGFloat yPosition = [self collectionViewContentSize].height - _cardSize.height;
    BOOL directionFromRight = arc4random() %2 == 0;
    CGFloat xPosition = directionFromRight ? [self collectionViewContentSize].width : -_cardSize.width;
    initialAttributes.frame = CGRectMake(xPosition, yPosition, _cardSize.width, _cardSize.height);
    initialAttributes.zIndex = 1000 - itemIndexPath.item;
    initialAttributes.hidden = false;
    CGFloat rotation = directionFromRight ? _angleOfRotationForNewCardAnimation : -_angleOfRotationForNewCardAnimation;
    initialAttributes.transform3D = CATransform3DMakeRotation(rotation, 0, 0, 0);
  }
  return initialAttributes;
}
- (UICollectionViewLayoutAttributes*) initialAttributesForTopStackItem:(UICollectionViewLayoutAttributes*)attributes {
  CGFloat minYPosition = _centralCardYPosition - _verticalOffsetBetweenCardsInTopStack * (_topStackMaxCount - 1);
  CGFloat yPosition = _centralCardYPosition - _verticalOffsetBetweenCardsInTopStack * (attributes.indexPath.row - _index);
  yPosition = MAX(yPosition, minYPosition);
  
  // right position for new card
  if (attributes.indexPath.item == [self.collectionView numberOfItemsInSection:0] - 1 && _newCardAnimatonInProgress) {
    if (attributes.indexPath.item >= _index && attributes.indexPath.item < _index + _topStackMaxCount) {
      yPosition = _centralCardYPosition - _verticalOffsetBetweenCardsInTopStack * (attributes.indexPath.row - _index);
    } else {
      attributes.hidden = true;
      yPosition = _centralCardYPosition;
    }
  }
  CGFloat xPosition =(self.collectionView.frame.size.width - _cardSize.width) / 2;
  attributes.frame = CGRectMake(xPosition, yPosition, _cardSize.width, _cardSize.height);
  
  return attributes;
}

- (UICollectionViewLayoutAttributes*) initialAttributesForBottomStackItem:(UICollectionViewLayoutAttributes*)attributes {
  CGFloat yPosition = self.collectionView.frame.size.height - _bottomStackCardHeight;
  CGFloat xPosition = (self.collectionView.frame.size.width - _cardSize.width) / 2;
  attributes.frame = CGRectMake(xPosition, yPosition, _cardSize.width, _cardSize.height);
  double angle = [_bottomStackRotations[@(attributes.indexPath.item)] doubleValue];
  if (angle) {
    attributes.transform3D = CATransform3DMakeRotation((CGFloat)angle, 0, 0, 1);
  }
  return attributes;
}

- (void)setDefaultValues {
  _newCardAnimatonInProgress = false;
  _coefficientOfrotation = 0.25;
  _angleOfRotationForNewCardAnimation = 0.25;
  _verticalOffsetBetweenCardsInTopStack = 10;
  _centralCardYPosition = 70;
  _bottomStackRotations = [NSMutableDictionary dictionary];
}
- (NSString*)layoutKeyForIndexpath:(NSIndexPath*)indexPath {
  return  [NSString stringWithFormat: @"%ld_%ld", (long)indexPath.section, (long)indexPath.row];
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewLayoutAttributes *attributesForItem = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath: indexPath];
  if (indexPath.item >= _index) {
    attributesForItem = [self initialAttributesForTopStackItem: attributesForItem];
    // hide cards that aren't visible in top stack
    attributesForItem.hidden = (attributesForItem.indexPath.item >= _index + _topStackMaxCount);
  } else {
    attributesForItem = [self initialAttributesForBottomStackItem: attributesForItem];
    // hide cards that aren't visible in bottom stack;
    attributesForItem.hidden = (attributesForItem.indexPath.item < (_index - _bottomStackMaxCount));
  }
  
  if (indexPath.item == _indexPathOfDraggedCell.item) {
    // workaround for zIndex
    attributesForItem.zIndex = 100000;
  } else {
    attributesForItem.zIndex = (indexPath.item >= _index) ? (1000 -indexPath.item) : (1000 + indexPath.item);
  }
  return  attributesForItem;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
  NSArray *indexPaths = [self indexPathsForElementsInRect: rect];
  NSMutableArray *attributesInRect = [NSMutableArray array];
  for (NSIndexPath *indexPath in indexPaths) {
    UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForItemAtIndexPath: indexPath];
    if (layoutAttributes != nil) {
      [attributesInRect addObject: layoutAttributes];
    }
  }
  return attributesInRect;
}

- (NSArray<NSIndexPath*>*) indexPathsForElementsInRect:(CGRect)rect {
  NSMutableArray *indexPaths = [NSMutableArray array];
  NSUInteger count = [self.collectionView numberOfItemsInSection: 0];
  NSUInteger topStackCount = MIN(count - (_index + 1), _topStackMaxCount - 1);
  NSUInteger bottomStackCount = MIN(_index, _bottomStackMaxCount);
  NSUInteger start = _index - bottomStackCount;
  NSUInteger end = _index + 1 + topStackCount;
  
  for (NSUInteger i = start; i < end; i++) {
    [indexPaths addObject: [NSIndexPath indexPathForItem: i inSection:0]];
  }
  return indexPaths;
}

- (CGSize)collectionViewContentSize {
  return self.collectionView.frame.size;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  return !(CGSizeEqualToSize(newBounds.size, self.collectionView.frame.size));
}

@end
