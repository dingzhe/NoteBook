#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGWeekly.h"


@protocol SWGWeeklyListResponses
@end
  
@interface SWGWeeklyListResponses : SWGObject


@property(nonatomic) NSString* message;

@property(nonatomic) NSNumber* code;

@property(nonatomic) NSArray<SWGWeekly>* data;

@end
