#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGWeekly.h"


@protocol SWGAddWeeklyRequest
@end
  
@interface SWGAddWeeklyRequest : SWGObject


@property(nonatomic) NSString* app;

@property(nonatomic) NSString* sign;

@property(nonatomic) NSString* time;

@property(nonatomic) SWGWeekly* weekly;

@end
