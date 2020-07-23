#ifndef CALL_CLIENT_H
#define CALL_CLIENT_H
#import <Foundation/Foundation.h>
#import <sdkmobile/Call.h>
#import <sdkmobile/CallsDelegate.h>
#import <sdkmobile/ActivationDelegate.h>

@interface CallClient : NSObject
-(instancetype)init NS_UNAVAILABLE;
-(void)activate:(NSString*)login password: (NSString*)password;
-(void)deactivate;
-(void)setOffline:(BOOL)offline;

-(void)callToNumber:(NSString*) number;
-(Call*)getCallByNumber:(NSString*) number;
-(Call*)getCallById:(NSNumber*) identifier;

@property(nonatomic,readwrite,assign) id<CallsDelegate> callsDelegate;
@property(nonatomic,readwrite,assign) id<ActivationDelegate> activaionDelegate;

-(void)setVoipPushCallId:(NSString*) indentifier;
-(void)setVoipPushCallToken:(NSString*) token;
@end
#endif
