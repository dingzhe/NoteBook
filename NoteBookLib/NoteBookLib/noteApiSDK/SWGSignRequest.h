#import <Foundation/Foundation.h>
#import "SWGObject.h"


@protocol SWGSignRequest
@end
  
@interface SWGSignRequest : SWGObject


@property(nonatomic) NSString* app;

@property(nonatomic) NSString* sign;

@property(nonatomic) NSString* time;

@property(nonatomic) NSString* username;

@property(nonatomic) NSString* password;

@end
