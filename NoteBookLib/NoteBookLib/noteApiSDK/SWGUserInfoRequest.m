#import "SWGUserInfoRequest.h"

@implementation SWGUserInfoRequest
  
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"app": @"app", @"sign": @"sign", @"time": @"time", @"uid": @"uid" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"app", @"sign", @"time", @"uid"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

@end
