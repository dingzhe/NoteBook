#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGAlreadyFavoriteBlog.h"


@protocol SWGFavoriteBlogResponses
@end
  
@interface SWGFavoriteBlogResponses : SWGObject


@property(nonatomic) NSString* message;

@property(nonatomic) NSNumber* code;

@property(nonatomic) NSArray<SWGAlreadyFavoriteBlog>* data;

@end
