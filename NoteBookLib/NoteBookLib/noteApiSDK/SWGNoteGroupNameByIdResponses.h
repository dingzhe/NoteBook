#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGNoteGroup.h"


@protocol SWGNoteGroupNameByIdResponses
@end
  
@interface SWGNoteGroupNameByIdResponses : SWGObject


@property(nonatomic) NSString* message;

@property(nonatomic) NSNumber* code;

@property(nonatomic) NSArray<SWGNoteGroup>* data;

@end
