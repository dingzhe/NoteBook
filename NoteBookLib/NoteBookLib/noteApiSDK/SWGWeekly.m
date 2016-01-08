#import "SWGWeekly.h"

@implementation SWGWeekly
  
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"weeklyid": @"weeklyid", @"username": @"username", @"uid": @"uid", @"title": @"title", @"content": @"content", @"dateline": @"dateline", @"private": @"private" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"weeklyid", @"username", @"uid", @"title", @"content", @"dateline", @"private"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

@end
