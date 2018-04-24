#ifndef COMMUNICATOR
#define COMMUNICATOR

#import <Foundation/Foundation.h>
#import <sdkmobile/CallClient.h>

@interface Communicator : NSObject
- (instancetype)init NS_UNAVAILABLE;
+(Communicator*)instance;
-(CallClient*)getCallClientInstance:(dispatch_queue_t)event_queue;
@end
#endif
