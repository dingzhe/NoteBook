#import "SWGFavoriteBlogListRequest.h"

@implementation SWGFavoriteBlogListRequest
  
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"app": @"app", @"sign": @"sign", @"time": @"time", @"uid": @"uid", @"size": @"size", @"pagenum": @"pagenum" }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"app", @"sign", @"time", @"uid", @"size", @"pagenum"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

@end
