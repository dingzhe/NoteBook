#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGWeekly.h"


@protocol SWGMyWeeklyResponses
@end
  
@interface SWGMyWeeklyResponses : SWGObject


@property(nonatomic) NSString* message;

@property(nonatomic) NSNumber* code;

@property(nonatomic) NSArray<SWGWeekly>* data;

@end
