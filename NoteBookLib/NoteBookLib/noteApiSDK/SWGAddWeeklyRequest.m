#import "SWGAddWeeklyRequest.h"

@implementation SWGAddWeeklyRequest
  
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"app": @"app", @"sign": @"sign", @"time": @"time", @"weeklyid": @"weeklyid", @"username": @"username", @"uid": @"uid", @"title": @"title", @"content": @"content", @"dateline": @"dateline", @"private": @"private" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"app", @"sign", @"time", @"weeklyid", @"username", @"uid", @"title", @"content", @"dateline", @"private"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

@end
