#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGId.h"


@protocol SWGIdList
@end
  
@interface SWGIdList : SWGObject


@property(nonatomic) NSArray<SWGId>* list;

@end
