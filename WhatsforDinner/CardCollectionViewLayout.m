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
  NSMutableDictionary<NSNumber*,NSNumber*> *_bottomStackRotations;
  BOOL _newCardAnimatonInProgress;
  double _coefficientOfrotation;
  CGFloat _angleOfRotationForNewCardAnimation;
  CGFloat _verticalOffsetBetweenCardsInTopStack;
  CGFloat _centralCardYPosition;
  UIPanGestureRecognizer *_panGesture;
  UISwipeGestureRecognizer *_swipeUp;
  UISwipeGestureRecognizer *_swipeDown;
  CGFloat _minimumXPanDistanceToSwipe;
  CGFloat _minimumYPanDistanceToSwipe;
}

@end

@implementation CardCollectionViewLayout
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _newCardAnimatonInProgress = NO;
    _gesturesEnabled = YES;
    _index = 0;
    _coefficientOfrotation = 0.25;
    _angleOfRotationForNewCardAnimation = 0.25;
    _verticalOffsetBetweenCardsInTopStack = 16;
    _centralCardYPosition = 90;
    _bottomStackRotations = [NSMutableDictionary dictionary];
    _minimumXPanDistanceToSwipe = 100;
    _minimumYPanDistanceToSwipe = 60;
  }
  return self;
}
- (void)setIndex:(int)index {
  _indexPathOfDraggedCell = _index > index ? [NSIndexPath indexPathForItem: index inSection:0] : [NSIndexPath indexPathForItem: _index inSection:0];
  _index = index;
  UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath: _indexPathOfDraggedCell];
  if (cell != nil) {
    [self.collectionView bringSubviewToFront: cell];
  }
  
  [self.collectionView performBatchUpdates:^{
    [self invalidateLayout];
  } completion:^(BOOL finished) {
    // TODO: tell delegate cardDidChange state (implement if needed)
  }];
}

- (void)setGesturesEnabled:(BOOL)gesturesEnabled {
  if (gesturesEnabled) {
    [self addGestures];
  } else {
    [self removeGestures];
  }
}
- (void)moveCardUp {
  if (_index > 0) {
    [self setIndex: self.index - 1];
  }
}

- (void)moveCardDown {
  if (self.index <= [self.collectionView numberOfItemsInSection: 0] - 1) {
    [self setIndex: self.index + 1];
  }
}
- (void)addGestures {
  _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(handlePan:)];
  [self.collectionView addGestureRecognizer: _panGesture];
  _panGesture.delegate = self;
  _swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(handleSwipe:)];
  _swipeUp.direction = UISwipeGestureRecognizerDirectionDown;
  [self.collectionView addGestureRecognizer: _swipeDown];
  _swipeDown.delegate = self;
  [_swipeDown requireGestureRecognizerToFail: _panGesture];
  
  _swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(handleSwipe:)];
  _swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
  [self.collectionView addGestureRecognizer: _swipeUp];
  _swipeUp.delegate = self;
  [_swipeUp requireGestureRecognizerToFail: _panGesture];
}

- (void) removeGestures {
  if (_panGesture != nil) {
    [self.collectionView removeGestureRecognizer: _panGesture];
  }
  if (_swipeUp != nil) {
    [self.collectionView removeGestureRecognizer: _swipeUp];
  }
  if (_swipeDown != nil) {
    [self.collectionView removeGestureRecognizer: _swipeDown];
  }
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
  // [super initialLayoutAttributesForAppearingItemAtIndexPath: itemIndexPath];
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

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewLayoutAttributes *attributesForItem = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath: indexPath];
  if (indexPath.item >= self.index) {
    attributesForItem = [self initialAttributesForTopStackItem: attributesForItem];
    // hide cards that aren't visible in top stack
    attributesForItem.hidden = (attributesForItem.indexPath.item >= self.index + _topStackMaxCount);
  } else {
    attributesForItem = [self initialAttributesForBottomStackItem: attributesForItem];
    // hide cards that aren't visible in bottom stack;
    attributesForItem.hidden = (attributesForItem.indexPath.item < (self.index - _bottomStackMaxCount));
  }
  
  if (indexPath.item ==  _indexPathOfDraggedCell.item) {
    // adjust zIndex for each item
    attributesForItem.zIndex = 100000;
  } else {
    attributesForItem.zIndex = (indexPath.item >= self.index) ? (1000 -indexPath.item) : (1000 + indexPath.item);
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
  int count = (int)[self.collectionView numberOfItemsInSection: 0];
  int topStackCount = MIN(count - (self.index + 1), _topStackMaxCount - 1);
  int bottomStackCount = MIN(self.index, _bottomStackMaxCount);
  int start = self.index - bottomStackCount;
  int end = self.index + 1 + topStackCount;
  
  for (int i = start; i < end; i++) {
    [indexPaths addObject: [NSIndexPath indexPathForItem: i inSection:0]];
  }
  return indexPaths;
}

- (CGSize)collectionViewContentSize {
  return self.collectionView.frame.size;
}

// TODO: - remove if not needed
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//  return !(CGSizeEqualToSize(newBounds.size, self.collectionView.frame.size));
//}


// MARK: handle gestures/pan
- (void) handleSwipe:(UISwipeGestureRecognizer*)sender {
  switch (sender.direction) {
    case UISwipeGestureRecognizerDirectionUp:
      [self setIndex: self.index - 1];
      break;
    case UISwipeGestureRecognizerDirectionDown:
      if (self.index + 1 < [self.collectionView numberOfItemsInSection: 0]) {
        [self setIndex: self.index + 1];
      }
      break;
  default:
    break;
  }
}
- (void) handlePan:(UIPanGestureRecognizer*)sender {
  if (sender.state == UIGestureRecognizerStateBegan) {
    CGPoint initialPanPoint = [sender locationInView: self.collectionView];
    [self findCellToDragByCoordinate: initialPanPoint];
  } else if (sender.state == UIGestureRecognizerStateChanged) {
    CGPoint newCenter = [sender translationInView: self.collectionView];
    [self udpateCenterPositionOfDraggedCell: newCenter];
  } else {
    if (_indexPathOfDraggedCell) {
      [self finishedDragging: [self.collectionView cellForItemAtIndexPath: _indexPathOfDraggedCell]];
    }
  }
}
// Determine which card to drag
- (void) findCellToDragByCoordinate:(CGPoint)touchCoordinate {
  NSIndexPath *indexPathAtTouch = [self.collectionView indexPathForItemAtPoint: touchCoordinate];
  if (indexPathAtTouch.item >= self.index) {
    // touch location is top stack
    NSLog(@"Top of stack");
    _indexPathOfDraggedCell = [NSIndexPath indexPathForItem: self.index inSection: 0];
    _initialCellCenter = [self.collectionView cellForItemAtIndexPath: _indexPathOfDraggedCell].center;
  } else {
    NSLog(@"Bottom of stack");
    if (_index > 0) {
      _indexPathOfDraggedCell = [NSIndexPath indexPathForItem: self.index - 1 inSection: 0];
    }
    _initialCellCenter = [self.collectionView cellForItemAtIndexPath: _indexPathOfDraggedCell].center;
    // fix issue with zIndex
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath: _indexPathOfDraggedCell];
    [self.collectionView bringSubviewToFront: cell];
  }
}

// change position of dragged card
- (void) udpateCenterPositionOfDraggedCell:(CGPoint)touchCoordinate {
  if (_indexPathOfDraggedCell) {
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath: _indexPathOfDraggedCell];
    CGFloat newCenterX = _initialCellCenter.x + touchCoordinate.x;
    CGFloat newCenterY = _initialCellCenter.y + touchCoordinate.y;
    cell.center = CGPointMake(newCenterX, newCenterY);
    CGFloat angle = (CGFloat)[self calculateAndStoreAngleOfRotation];
    cell.transform = CGAffineTransformMakeRotation(angle);
  }
}

// handle when user finishes dragging a cell if distance that user swiped was small, then don't move the card down
- (void) finishedDragging:(UICollectionViewCell*)cell {
  CGFloat deltaX = fabs(cell.center.x - _initialCellCenter.x);
  CGFloat deltaY = fabs(cell.center.y - _initialCellCenter.y);
  BOOL shouldSnapBack = deltaX < _minimumXPanDistanceToSwipe && deltaY < _minimumYPanDistanceToSwipe;
  if (shouldSnapBack) {
    [UIView setAnimationsEnabled: NO];
    [self.collectionView reloadItemsAtIndexPaths: @[_indexPathOfDraggedCell]];
    [UIView setAnimationsEnabled: YES];
  } else {
    [self calculateAndStoreAngleOfRotation];
    if (_indexPathOfDraggedCell.item == self.index) {
      [self setIndex: self.index + 1];
    } else {
      [self setIndex: self.index - 1];
    }
    _initialCellCenter = CGPointZero;
    _indexPathOfDraggedCell = nil;
  }
}

// Compute and store angle of rotation TODO: don't like how this method calculates and stores maybe split up
- (double) calculateAndStoreAngleOfRotation {
  double angle = 0;
  if (_indexPathOfDraggedCell) {
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath: _indexPathOfDraggedCell];
    CGFloat centerYIncidence = self.collectionView.frame.size.height + _cardSize.height - _bottomStackCardHeight;
    double gamma = (double)((cell.center.x - self.collectionView.bounds.size.width / 2) / (centerYIncidence - cell.center.y));
    angle = atan(gamma);
    NSNumber *value = [NSNumber numberWithDouble: angle * _coefficientOfrotation];
    NSNumber *indexPath = [NSNumber numberWithUnsignedInteger: _indexPathOfDraggedCell.item];
    _bottomStackRotations[indexPath] = value;
  }
  return angle;
}

// MARK: - appearance of new card
- (void) handleAddingNewCard:(int)newCardIndex {
  [self.collectionView performBatchUpdates:^{
    _newCardAnimatonInProgress = true;
    [self.collectionView insertItemsAtIndexPaths: @[[NSIndexPath indexPathForItem: newCardIndex inSection: 0]]];
  } completion:^(BOOL finished) {
    _newCardAnimatonInProgress = false;
  }];
}

// MARK: - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  BOOL shouldBegin = true;
  if (gestureRecognizer == _panGesture) {
    CGPoint velocity = [_panGesture velocityInView: self.collectionView];
    shouldBegin = abs((int)velocity.y) < 250;
  }
  return shouldBegin;
}
@end
