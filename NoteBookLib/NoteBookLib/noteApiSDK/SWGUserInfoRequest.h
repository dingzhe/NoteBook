#import <Foundation/Foundation.h>
#import "SWGObject.h"


@protocol SWGUserInfoRequest
@end
  
@interface SWGUserInfoRequest : SWGObject


@property(nonatomic) NSString* app;

@property(nonatomic) NSString* sign;

@property(nonatomic) NSString* time;

@property(nonatomic) NSString* uid;

@end
