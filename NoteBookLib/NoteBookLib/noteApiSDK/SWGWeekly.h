#import <Foundation/Foundation.h>
#import "SWGObject.h"


@protocol SWGWeekly
@end
  
@interface SWGWeekly : SWGObject


@property(nonatomic) NSString* weeklyid;

@property(nonatomic) NSString* username;

@property(nonatomic) NSString* uid;

@property(nonatomic) NSString* title;

@property(nonatomic) NSString* content;

@property(nonatomic) NSString* dateline;

@property(nonatomic) NSString* private;

@end
