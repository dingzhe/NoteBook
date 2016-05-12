#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGEmptyResponses.h"


@protocol SWGNoteGroupResponses
@end
  
@interface SWGNoteGroupResponses : SWGObject


@property(nonatomic) NSString* message;

@property(nonatomic) NSNumber* code;

@property(nonatomic) NSArray<SWGEmptyResponses>* data;

@end
