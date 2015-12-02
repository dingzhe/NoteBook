//
//  RACCommand+Ext.m
//  bolome_shared
//
//  Created by by on 6/3/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import "RACCommand+Ext.h"

@implementation RACCommand(Ext)

- (RACSignal *) responses {
    return [self.executionSignals switchToLatest];
}

@end
