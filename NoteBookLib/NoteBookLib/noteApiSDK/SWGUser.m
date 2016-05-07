#import "SWGUser.h"

@implementation SWGUser
  
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"userid": @"userid", @"username": @"username", @"sex": @"sex", @"email": @"email", @"phone": @"phone", @"headimage": @"headimage", @"token": @"token" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"userid", @"username", @"sex", @"email", @"phone", @"headimage", @"token"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

@end
