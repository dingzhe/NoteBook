#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGNoteGroup.h"


@protocol SWGNoteGroupListResponses
@end
  
@interface SWGNoteGroupListResponses : SWGObject


@property(nonatomic) NSString* message;

@property(nonatomic) NSNumber* code;

@property(nonatomic) NSArray<SWGNoteGroup>* data;

@end
