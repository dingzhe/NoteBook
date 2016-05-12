#import "SWGNoteGroupRequest.h"

@implementation SWGNoteGroupRequest
  
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"app": @"app", @"sign": @"sign", @"time": @"time", @"uid": @"uid", @"groupid": @"groupid", @"weeklyid": @"weeklyid" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"app", @"sign", @"time", @"uid", @"groupid", @"weeklyid"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

@end
