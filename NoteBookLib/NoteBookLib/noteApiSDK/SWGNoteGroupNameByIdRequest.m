#import "SWGNoteGroupNameByIdRequest.h"

@implementation SWGNoteGroupNameByIdRequest
  
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"app": @"app", @"sign": @"sign", @"time": @"time", @"uid": @"uid", @"groupid": @"groupid" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"app", @"sign", @"time", @"uid", @"groupid"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

@end
