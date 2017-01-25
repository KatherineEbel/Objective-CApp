//
//  CardCollectionViewLayout.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/22/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardLayoutDelegate.h"
NS_ASSUME_NONNULL_BEGIN
@interface CardCollectionViewLayout : UICollectionViewLayout <UIGestureRecognizerDelegate>
@property (nonatomic) int index;
@property (nonatomic) IBInspectable int topStackMaxCount;
@property (nonatomic) IBInspectable int bottomStackMaxCount;
@property (nonatomic) IBInspectable CGFloat bottomStackCardHeight;
@property (nonatomic) IBInspectable CGSize cardSize;
@property (nonatomic) IBInspectable UIEdgeInsets cardInsets;
@property (nonatomic) IBInspectable BOOL newCardShouldAppearOnBottom;

@end
NS_ASSUME_NONNULL_END
