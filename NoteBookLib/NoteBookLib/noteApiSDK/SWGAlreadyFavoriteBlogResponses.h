#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGAlreadyFavoriteBlog.h"


@protocol SWGAlreadyFavoriteBlogResponses
@end
  
@interface SWGAlreadyFavoriteBlogResponses : SWGObject


@property(nonatomic) NSString* message;

@property(nonatomic) NSNumber* code;

@property(nonatomic) NSArray<SWGAlreadyFavoriteBlog>* data;

@end
