#import <Foundation/Foundation.h>
#import "SWGObject.h"


@protocol SWGUser
@end
  
@interface SWGUser : SWGObject


@property(nonatomic) NSString* userid;

@property(nonatomic) NSString* username;

@property(nonatomic) NSString* token;

@end
