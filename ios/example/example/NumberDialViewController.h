//
//  ViewController.h
//  sdkmobile_example
//
//  Created by user on 14.03.18.
//  Copyright © 2018 mtt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sdkmobile/CallsDelegate.h>

@interface NumberDialViewController : UIViewController<CallsDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource> {
    __weak IBOutlet UITextField *tfNumber;
    __weak IBOutlet UITableView *tvCalls;
}
@end

