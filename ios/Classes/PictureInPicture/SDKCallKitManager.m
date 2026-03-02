//
//  SDKCallKitManager.m
//
//  CallKit removed. No-op stub kept for source compatibility.
//  All other files that import SDKCallKitManager.h continue to compile
//  without modification.
//

#import "SDKCallKitManager.h"

@implementation SDKCallKitManager

+ (instancetype)sharedManager {
  static SDKCallKitManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

- (void)setEnableCallKit:(BOOL)enable {
  // no-op: CallKit removed
}

- (void)startCallWithHandle:(NSString *)handle
                   complete:(void (^)(void))completion {
  // no-op: CallKit removed
  // Still invoke completion so PiP flow continues uninterrupted
  if (completion) {
    dispatch_async(dispatch_get_main_queue(), ^{
      completion();
    });
  }
}

- (void)endCallWithComplete:(void (^)(void))completion {
  // no-op: CallKit removed
  if (completion) {
    dispatch_async(dispatch_get_main_queue(), ^{
      completion();
    });
  }
}

- (BOOL)isInCall {
  return NO;
}

@end
