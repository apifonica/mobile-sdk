//
//  CallClientOwner.h
//  sdkmobile_example
//
//  Created by user on 26.03.18.
//  Copyright © 2018 mtt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import <sdkmobile/ActivationDelegate.h>
#import <sdkmobile/CallsDelegate.h>

typedef enum ActivationState {
    AS_Deactivated = 0,
    AS_Activated,
    AS_ActivationNone,
    AS_ActivationInProgress,
    AS_ActivationError
} ActivationState;


@interface CallClientWrapper: NSObject<ActivationDelegate>
-(instancetype)init NS_UNAVAILABLE;
+(CallClientWrapper*)instance;

-(void)activate:(NSString*)account password: (NSString*)password;
-(void)deactivate;
-(void)callToNumber:(NSString*)number;
-(Call*)getCallById:(NSNumber*)identifier;
-(Call*)getCallByNumber:(NSString*)identifier;

@property(nonatomic,readwrite,assign) id<CallsDelegate> callsDelegate;
@property(nonatomic,assign) ActivationState activationState;

@end

extern NSNotificationName const ActivationStateNotification;
extern NSNotificationName const ActivationStateNotificationStateKey;
