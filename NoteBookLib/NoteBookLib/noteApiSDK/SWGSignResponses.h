#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGUser.h"


@protocol SWGSignResponses
@end
  
@interface SWGSignResponses : SWGObject


@property(nonatomic) NSString* message;

@property(nonatomic) NSNumber* code;

@property(nonatomic) SWGUser* data;

@end
