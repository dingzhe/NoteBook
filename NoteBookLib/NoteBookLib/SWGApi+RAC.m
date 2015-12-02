//
//  SWGApi+RAC.m
//  NoteBookLib
//
//  Created by dz on 15/11/24.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import "SWGApi+RAC.h"
#import "NoteBookLib_gen.h"
#import "ErrorHandlerManager.h"
#import "RACSignal+Ext.h"
#import <ReactiveCocoa/NSInvocation+RACTypeParsing.h>

@implementation SWGApi (RAC)
#pragma mark - private methods

- (void) _tellSubscriber:(id<RACSubscriber>)subscriber
   didCompleteWithOupput:(id)output
                   error:(NSError *)error {
    
    id successObj = nil;
    id failObj = nil;
    
    // add handle error in 200
    if (output!=nil && [output isKindOfClass:[SWGObject class]]) {
        SWGObject *object  = (SWGObject *)output;
        NSDictionary *info = [object toDictionary];
        if ([info[@"ret_code"] intValue] == 1) {
            NSString *error_message = @"未知错误";
            if (info[@"error_message"]!=nil) {
                error_message = info[@"error_message"];
            }
            NSDictionary *dataDic = [NSDictionary dictionaryWithObjectsAndKeys:error_message,@"message",nil];
            NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:dataDic,@"data",nil];
            NSHTTPURLResponse *resposne = [[NSHTTPURLResponse alloc]initWithURL:nil statusCode:200 HTTPVersion:nil headerFields:nil];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:errorDict,SWGResponseObjectErrorKey,resposne,AFNetworkingOperationFailingURLResponseErrorKey,nil];
            
            NSError *addtionalError = [[NSError alloc]initWithDomain:AFURLResponseSerializationErrorDomain code:200 userInfo:userInfo];
            error = addtionalError;
        }
    }
    
    if (error) {
        failObj = error;
    }
    else {
        successObj = output;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
            [subscriber sendError:error];
        }
        else {
            [subscriber sendNext:output];
            [subscriber sendCompleted];
        }
        
        if (error && ErrorHandlerManager.manager.dalErrorHandler) {
            [ErrorHandlerManager.manager.dalErrorHandler process:error];
        }
    });
}
+ (RACSignal *) _executionWithTarget:(id)target
                            selector:(SEL)selector
                               input:(id)input
                         willExecute:(NSError *(^)(id input)) willExecuteBlock
                         executeArgs:(NSArray *(^)(id input, id<RACSubscriber>subscriber)) executeArgsBlock
                          didExecute:(NSError *(^)(id input, id result)) didExecuteBlock
                       cancleExecute:(void (^)(id input, id result)) cancelExecuteBlock {
    @weakify(target)
    
    RACSignal *result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(target)
        
        NSError *error = nil;
        
        if (willExecuteBlock && (error = willExecuteBlock(input))) {
            [subscriber sendError:error];
            return nil;
        }
        
        NSMethodSignature *signature = [target methodSignatureForSelector:selector];
        __block NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.selector = selector;
        invocation.target = target;
        
        __block NSInteger argIndex = 2;
        NSArray *arguments = nil;
        
        if (executeArgsBlock) {
            arguments = executeArgsBlock(input, subscriber);
            NSAssert(!arguments || [arguments isKindOfClass:NSArray.class], @"arguments must be array");
        }
        
        [arguments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [invocation rac_setArgument:obj atIndex:argIndex++];
        }];
        
        [invocation invoke];
        
        id returnValue = [invocation rac_returnValue];
        
        if (didExecuteBlock && (error = didExecuteBlock(input, returnValue))) {
            [subscriber sendError:error];
            return nil;
        }
        
        return [RACDisposable disposableWithBlock:^{
            !cancelExecuteBlock ? : cancelExecuteBlock(input, returnValue);
        }];
    }];
    
    result.executionInput = input;
    
    return result;
}
- (RACCommand *) commandWithSelector:(SEL)selector
                             enabled:(RACSignal *)enabled
                         willExecute:(NSError *(^)(id input)) willExecuteBlock
                         executeArgs:(NSArray *(^)(id input, id<RACSubscriber>subscriber)) executeArgsBlock
                          didExecute:(NSError *(^)(id input, id result)) didExecuteBlock
                       cancleExecute:(void (^)(id input, id result)) cancelExecuteBlock {
    @weakify(self)
    
    return [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal *(id input) {
        @strongify(self)
        
        return [self.class _executionWithTarget:self
                                       selector:selector
                                          input:input
                                    willExecute:willExecuteBlock
                                    executeArgs:executeArgsBlock
                                     didExecute:didExecuteBlock
                                  cancleExecute:cancelExecuteBlock];
    }];
}
- (RACCommand *) commandWithSelector:(SEL)selector enabled:(RACSignal *)enabled {
    @weakify(self)
    
    return [self commandWithSelector:selector
                             enabled:enabled
                         willExecute:nil
                         executeArgs:^NSArray *(id input, id<RACSubscriber> subscriber) {
                             @strongify(self)
                             
                             NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:8];
                             
                             if ([input isKindOfClass:NSArray.class]) {
                                 NSMutableArray *newInput = [NSMutableArray array];
                                 for (id obj in input) {
                                     if ([obj isKindOfClass:[SWGObject class]]) {
                                         [newInput addObject:obj];
                                     }else{
                                         [newInput addObject:obj];
                                     }
                                 }
                                 [arguments addObjectsFromArray:(NSArray *)newInput];
                             }
                             else if (input) {
                                 [arguments addObject:input];
                             }
                             
                             void (^subscriberBlock)(id, id)  = ^(id output, id error) {
                                 // this is been called on background thread
                                 [self _tellSubscriber:subscriber
                                 didCompleteWithOupput:output
                                                 error:error];
                             };
                             
                             [arguments addObject:[subscriberBlock copy]];
                             
                             return arguments;
                         }
                          didExecute:nil
                       cancleExecute:^(id input, NSNumber *requestId) {
                           @strongify(self)
                           
                           [self.apiClient cancelRequest:requestId];
                       }];
}


@end
