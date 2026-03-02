//
//  SDKCallKitManager.h
//
//  CallKit removed. Stub interface kept for source compatibility.
//

#import <Foundation/Foundation.h>

@interface SDKCallKitManager : NSObject

@property(nonatomic, assign, readonly) BOOL isInCall;

+ (instancetype)sharedManager;
- (void)startCallWithHandle:(NSString *)handle
                   complete:(void (^)(void))completion;
- (void)endCallWithComplete:(void (^)(void))completion;
- (void)setEnableCallKit:(BOOL)enable;

@end
