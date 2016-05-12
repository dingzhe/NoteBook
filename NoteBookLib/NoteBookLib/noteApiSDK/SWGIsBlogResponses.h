#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGEmptyResponses.h"


@protocol SWGIsBlogResponses
@end
  
@interface SWGIsBlogResponses : SWGObject


@property(nonatomic) NSString* message;

@property(nonatomic) NSNumber* code;

@property(nonatomic) NSArray<SWGEmptyResponses>* data;

@end
