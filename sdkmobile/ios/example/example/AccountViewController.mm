//
//  AccountViewController.m
//  sdkmobile_example
//
//  Created by user on 26.03.18.
//  Copyright © 2018 mtt. All rights reserved.
//

#import "AccountViewController.h"
#import "CallClientWrapper.h"

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(activationStateChangedNotification:)
                                                 name:ActivationStateNotification
                                               object:nil];
    [self updateActivateButtonState];
}

- (IBAction)onToogleActivation:(id)sender {
    if([CallClientWrapper instance].activationState == AS_Deactivated)
        [[CallClientWrapper instance] activate:tfAccount.text password:tfPassword.text];
    else
        [[CallClientWrapper instance] deactivate];
}

-(void)activationStateChangedNotification: (NSDictionary*)userInfo {
    [self updateActivateButtonState];
}

-(void)updateActivateButtonState {
    ActivationState activationState = [CallClientWrapper instance].activationState;
    switch (activationState) {
        case AS_Deactivated:
            [btAccountToogle setTitle:@"Activate" forState:UIControlStateNormal];
            btAccountToogle.enabled = YES;
            break;
        case AS_Activated:
            [btAccountToogle setTitle:@"Deactivate" forState:UIControlStateNormal];
            btAccountToogle.enabled = YES;
            break;
        case AS_ActivationNone:
            [btAccountToogle setTitle:@"Deactivate" forState:UIControlStateNormal];
            btAccountToogle.enabled = YES;
            break;
        case AS_ActivationError:
            [btAccountToogle setTitle:@"Activate" forState:UIControlStateNormal];
            btAccountToogle.enabled = YES;
            break;
        case AS_ActivationInProgress:
            [btAccountToogle setTitle:@"Activating ..." forState:UIControlStateNormal];
            btAccountToogle.enabled = NO;
            break;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if(tfAccount.isFirstResponder)
        [tfAccount resignFirstResponder];
    if(tfPassword.isFirstResponder)
        [tfPassword resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
