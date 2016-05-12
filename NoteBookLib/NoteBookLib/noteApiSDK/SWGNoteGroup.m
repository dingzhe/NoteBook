#import "SWGNoteGroup.h"

@implementation SWGNoteGroup
  
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"groupid": @"groupid", @"groupname": @"groupname", @"userid": @"userid" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"groupid", @"groupname", @"userid"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

@end
