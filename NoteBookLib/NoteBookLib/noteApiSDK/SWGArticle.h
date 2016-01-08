#import <Foundation/Foundation.h>
#import "SWGObject.h"


@protocol SWGArticle
@end
  
@interface SWGArticle : SWGObject


@property(nonatomic) NSString* _id;

@property(nonatomic) NSString* title;

@property(nonatomic) NSString* author;

@property(nonatomic) NSString* _description;

@property(nonatomic) NSString* content;

@property(nonatomic) NSString* dateline;

@end
