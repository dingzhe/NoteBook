//
//  UIButton+RACCommandSupport+Ext.h
//  bolome_shared
//
//  Created by by on 4/7/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface UIButton(RACCommandSupport_Ext)

@property (nonatomic, strong) NSString *normalStateTitle;

- (void) setEnabled:(RACSignal *)enabled actionBlock:(void(^)(UIButton *sender))actionBlock;

@end

#pragma mark -

@interface RACCommand(UIButton)

+ (RACCommand *) commandWithEnabled:(RACSignal *)enabled
                              block:(void (^)(id input))block;

+ (RACCommand *) commandWithBlock:(void (^)(id input))block;

@end
