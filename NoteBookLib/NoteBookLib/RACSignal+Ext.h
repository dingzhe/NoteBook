//
//  RACSignal+Ext.h
//  bolome_shared
//
//  Created by by on 4/11/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACSignal(Ext)

@property (nonatomic, strong) id executionInput;

+ (RACSignal *)after:(NSTimeInterval)interval onScheduler:(RACScheduler *)scheduler;

@end
