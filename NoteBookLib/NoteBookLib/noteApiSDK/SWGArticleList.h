#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGArticle.h"


@protocol SWGArticleList
@end
  
@interface SWGArticleList : SWGObject


@property(nonatomic) NSArray<SWGArticle>* list;

@end
