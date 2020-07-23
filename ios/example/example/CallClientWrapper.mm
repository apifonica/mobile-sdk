//
//  CallClientOwner.m
//  sdkmobile_example
//
//  Created by user on 26.03.18.
//  Copyright © 2018 mtt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sdkMobile/Communicator.h>
#import "CallClientWrapper.h"


static CallClientWrapper* sHolder = nil;

NSNotificationName const ActivationStateNotification = @"ActivationStateNotification";
NSNotificationName const ActivationStateNotificationStateKey = @"ActivationStateNotificationStateKey";

@implementation CallClientWrapper {
    CallClient* callClient;
}

@synthesize activationState = _activationState;

-(void)activated {
    NSLog(@"%s", __FUNCTION__);
    _activationState = AS_Activated;
    [self postActivationEvent];
}
-(void)deactivated {
    NSLog(@"%s", __FUNCTION__);
    _activationState = AS_Deactivated;
    [self postActivationEvent];
}
-(void)activationNone {
    NSLog(@"%s", __FUNCTION__);
    _activationState = AS_ActivationNone;
    [self postActivationEvent];
}
-(void)activationInProgress {
    NSLog(@"%s", __FUNCTION__);
    _activationState = AS_ActivationInProgress;
    [self postActivationEvent];
}
-(void)activationError:(ActivationError) error {
    NSLog(@"%s", __FUNCTION__);
    _activationState = AS_ActivationError;
    [self postActivationEvent];
}

-(void)postActivationEvent {
    [[NSNotificationCenter defaultCenter] postNotificationName:ActivationStateNotification object:self userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:_activationState] forKey:ActivationStateNotificationStateKey]];
}

+(CallClientWrapper*)instance {
    if(sHolder == nil)
        sHolder = [[CallClientWrapper alloc] initInternal];
    return sHolder;
}

-(void)activate:(NSString*)account password: (NSString*)password {
    [callClient activate:account password:password];
}

-(void)deactivate {
    [callClient deactivate];
}

-(void)callToNumber:(NSString*)number {
    [callClient callToNumber:number];
}

-(Call*)getCallById:(NSNumber*)identifier {
    return [callClient getCallById:identifier];
}

-(Call*)getCallByNumber:(NSString*)identifier {
    return [callClient getCallByNumber:identifier];
}

-(void)setCallsDelegate:(id<CallsDelegate>)callsDelegate {
    callClient.callsDelegate = callsDelegate;
}

-(id<CallsDelegate>)getCallsDelegate {
    return callClient.callsDelegate;
}

-(id)initInternal {
    self = [super init];
    if(self) {
        callClient = [[Communicator instance] getCallClientInstance:dispatch_get_main_queue()];
        callClient.activaionDelegate = self;
    }
    return self;
}

@end
