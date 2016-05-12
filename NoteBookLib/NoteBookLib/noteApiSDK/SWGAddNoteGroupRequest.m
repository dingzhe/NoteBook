#import "SWGAddNoteGroupRequest.h"

@implementation SWGAddNoteGroupRequest
  
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"app": @"app", @"sign": @"sign", @"time": @"time", @"uid": @"uid", @"groupname": @"groupname" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"app", @"sign", @"time", @"uid", @"groupname"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

@end
