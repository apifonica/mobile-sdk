#ifndef CALL_H
#define CALL_H
#import <Foundation/Foundation.h>
#import <sdkmobile/SdkTypes.h>

@interface Call : NSObject
@property(copy,readonly) NSNumber* identifier;
@property(copy,readonly) NSString* number;
@property(readonly) CallDirection direction;
@property(readonly) BOOL hasVideo;

- (instancetype)init NS_UNAVAILABLE;
-(void)accept;
-(void)terminate;
-(void)pause;
-(void)resume;
-(void)transfer:(Call*) call;
-(void)merge:(Call*) call;
@end
#endif
