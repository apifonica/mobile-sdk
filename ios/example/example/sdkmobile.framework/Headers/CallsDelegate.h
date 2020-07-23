#ifndef CALLS_DELEGATE
#define CALLS_DELEGATE
#import <sdkmobile/Call.h>
#import <sdkmobile/SdkTypes.h>

@protocol CallsDelegate
-(void)callReceived:(Call*)call;
-(void)callTrying:(Call*)call;
-(void)callEstablished:(Call*)call;
-(void)callPaused:(Call*)call;
-(void)callResuming:(Call*)call;
-(void)callResumed:(Call*)call;
-(void)callError:(Call*)call callError:(CallError)error;
-(void)callTerminated:(Call*)call;
@end
#endif
