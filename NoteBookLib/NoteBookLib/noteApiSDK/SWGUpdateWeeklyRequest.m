#import "SWGUpdateWeeklyRequest.h"

@implementation SWGUpdateWeeklyRequest
  
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"app": @"app", @"sign": @"sign", @"time": @"time", @"uid": @"uid", @"weeklyid": @"weeklyid", @"title": @"title", @"content": @"content", @"dateline": @"dateline", @"private": @"private" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"app", @"sign", @"time", @"uid", @"weeklyid", @"title", @"content", @"dateline", @"private"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

@end
