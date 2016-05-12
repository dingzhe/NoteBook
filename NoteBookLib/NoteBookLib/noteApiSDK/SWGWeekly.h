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

@property(nonatomic) NSString* createtime;

@property(nonatomic) NSString* updatetime;

@property(nonatomic) NSString* isblog;

@property(nonatomic) NSString* blogurl;

@property(nonatomic) NSString* groupid;

@end
