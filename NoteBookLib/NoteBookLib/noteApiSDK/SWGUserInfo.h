#import <Foundation/Foundation.h>
#import "SWGObject.h"


@protocol SWGUserInfo
@end
  
@interface SWGUserInfo : SWGObject


@property(nonatomic) NSString* userid;

@property(nonatomic) NSString* username;

@property(nonatomic) NSString* sex;

@property(nonatomic) NSString* headimage;

@property(nonatomic) NSString* phone;

@property(nonatomic) NSString* email;

@property(nonatomic) NSString* about;

@end
