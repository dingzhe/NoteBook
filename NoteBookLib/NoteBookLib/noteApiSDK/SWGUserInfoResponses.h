#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGUserInfo.h"


@protocol SWGUserInfoResponses
@end
  
@interface SWGUserInfoResponses : SWGObject


@property(nonatomic) NSString* message;

@property(nonatomic) NSNumber* code;

@property(nonatomic) NSArray<SWGUserInfo>* data;

@end
