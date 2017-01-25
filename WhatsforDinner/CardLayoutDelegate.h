//
//  CardLayoutDelegate.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/24/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardLayoutDelegate.h"

@protocol CardLayoutDelegate <NSObject>
@property (nonatomic, weak) id <CardLayoutDelegate> delegate;
@property (nonatomic) IBInspectable int topStackMaxCount;
@property (nonatomic) IBInspectable int bottomStackMaxCount;
@property (nonatomic) IBInspectable int bottomStackCardHeight;
@property (nonatomic) IBInspectable CGSize cardSize;
@property (nonatomic) IBInspectable UIEdgeInsets cardInsets;
@property (nonatomic) IBInspectable BOOL newCardShouldAppearOnBottom;

@end
