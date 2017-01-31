//
//  SPNObject.h
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/28/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPNObject <NSObject>
@optional
+ (RKObjectMapping *) propertyMapping;
- (NSDictionary*) queryParams;
+ (RKRelationshipMapping*) relationshipMapping;
@end
