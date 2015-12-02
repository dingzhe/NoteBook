#import "SWGGetArticleByIdRequest.h"

@implementation SWGGetArticleByIdRequest
  
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"id": @"_id", @"api": @"api" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"_id", @"api"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

@end
