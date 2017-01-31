//
//  UIViewController+ViewControllerErrorAlert.m
//  WhatsforDinner
//
//  Created by Katherine Ebel on 1/31/17.
//  Copyright © 2017 Katherine Ebel. All rights reserved.
//

#import "UIViewController+ViewControllerErrorAlert.h"
#import <UIKit/UIKit.h>

@implementation UIViewController (ViewControllerErrorAlert)
- (void)alertForError:(NSString *)message {
  __block UIAlertController *alertController;
  alertController = [UIAlertController alertControllerWithTitle: @"Sorry! Something went wrong" message: message preferredStyle: UIAlertControllerStyleAlert];
  UIAlertAction *okAction = [UIAlertAction actionWithTitle: @"OK" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    alertController = nil;
  }];
  [alertController addAction: okAction];
  [self presentViewController: alertController animated:true completion: nil];
}
@end
