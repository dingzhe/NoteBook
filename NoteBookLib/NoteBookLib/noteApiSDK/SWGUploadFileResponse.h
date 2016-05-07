#import <Foundation/Foundation.h>
#import "SWGObject.h"


@protocol SWGUploadFileResponse
@end
  
@interface SWGUploadFileResponse : SWGObject


@property(nonatomic) NSString* url;

@property(nonatomic) NSNumber* code;

@property(nonatomic) NSString* message;

@end
