//
//  NSObject+RACCommandSupport+Ext.h
//  bolome_shared
//
//  Created by by on 4/10/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface NSObject(RAC_Ext)

- (RACSignal *) observeNotification:(NSString *)notificationName;
- (RACSignal *) observeNotification:(NSString *)notificationName object:(id)object;

+ (RACCommand *) commandWithSelector:(SEL)selector
                             enabled:(RACSignal *)enabled
                         willExecute:(NSError *(^)(id input)) willExecuteBlock
                         executeArgs:(NSArray *(^)(id input, id<RACSubscriber>subscriber)) executeArgsBlock
                          didExecute:(NSError *(^)(id input, id result)) didExecuteBlock
                       cancleExecute:(void (^)(id input, id result)) cancelExecuteBlock;

- (RACCommand *) commandWithSelector:(SEL)selector
                             enabled:(RACSignal *)enabled
                         willExecute:(NSError *(^)(id input)) willExecuteBlock
                         executeArgs:(NSArray *(^)(id input, id<RACSubscriber>subscriber)) executeArgsBlock
                          didExecute:(NSError *(^)(id input, id result)) didExecuteBlock
                       cancleExecute:(void (^)(id input, id result)) cancelExecuteBlock;

@end
