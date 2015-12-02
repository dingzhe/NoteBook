#import "SWGGetArticleByIdResponse.h"

@implementation SWGGetArticleByIdResponse
  
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"id": @"_id", @"title": @"title", @"author": @"author", @"description": @"_description", @"content": @"content", @"dateline": @"dateline" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"_id", @"title", @"author", @"_description", @"content", @"dateline"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

@end
