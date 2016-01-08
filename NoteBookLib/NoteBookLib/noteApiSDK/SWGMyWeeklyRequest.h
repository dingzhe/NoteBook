#import <Foundation/Foundation.h>
#import "SWGObject.h"


@protocol SWGMyWeeklyRequest
@end
  
@interface SWGMyWeeklyRequest : SWGObject


@property(nonatomic) NSString* app;

@property(nonatomic) NSString* sign;

@property(nonatomic) NSString* time;

@property(nonatomic) NSString* uid;

@end
