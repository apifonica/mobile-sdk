//
//  AccountViewController.h
//  sdkmobile_example
//
//  Created by user on 26.03.18.
//  Copyright © 2018 mtt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController<UIGestureRecognizerDelegate> {
    
    __weak IBOutlet UITextField *tfAccount;
    __weak IBOutlet UITextField *tfPassword;
    __weak IBOutlet UIButton *btAccountToogle;
}

@end
