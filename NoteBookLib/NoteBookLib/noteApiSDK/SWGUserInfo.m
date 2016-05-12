#import "SWGUserInfo.h"

@implementation SWGUserInfo
  
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"userid": @"userid", @"username": @"username", @"sex": @"sex", @"headimage": @"headimage", @"phone": @"phone", @"email": @"email", @"about": @"about" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"userid", @"username", @"sex", @"headimage", @"phone", @"email", @"about"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

@end
