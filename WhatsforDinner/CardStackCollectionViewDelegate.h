//
//  CardStackCollectionViewDelegate.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/22/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

@protocol CardStackCollectionViewDelegate <NSObject>
- (void)cardDidChangeState:(int)cardIndex;
@end
