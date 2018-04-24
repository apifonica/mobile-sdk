#ifndef ACTIVATION_DELEGATE
#define ACTIVATION_DELEGATE
#import <sdkmobile/SdkTypes.h>

@protocol ActivationDelegate
-(void)activated;
-(void)deactivated;
-(void)activationNone;
-(void)activationInProgress;
-(void)activationError:(ActivationError) error;
@end
#endif
