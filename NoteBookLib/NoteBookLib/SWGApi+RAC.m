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
#import "NSString+Ext.h"

static NSString * const kVSCharactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";

static NSString * VSPercentEscapedQueryStringKeyFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    static NSString * const kVSCharactersToLeaveUnescapedInQueryStringPairKey = @"";
    
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, (__bridge CFStringRef)kVSCharactersToLeaveUnescapedInQueryStringPairKey, (__bridge CFStringRef)kVSCharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
}

static NSString * VSPercentEscapedQueryStringValueFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)kVSCharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
}
@interface VSQueryStringPair : NSObject
@property (readwrite, nonatomic, strong) id field;
@property (readwrite, nonatomic, strong) id value;

- (id)initWithField:(id)field value:(id)value;

- (NSString *)URLEncodedStringValueWithEncoding:(NSStringEncoding)stringEncoding;
@end

@implementation VSQueryStringPair

- (id)initWithField:(id)field value:(id)value {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.field = field;
    self.value = value;
    
    return self;
}

- (NSString *)URLEncodedStringValueWithEncoding:(NSStringEncoding)stringEncoding {
    if (!self.value || [self.value isEqual:[NSNull null]]) {
        return VSPercentEscapedQueryStringKeyFromStringWithEncoding([self.field description], stringEncoding);
    } else {
        return [NSString stringWithFormat:@"%@=%@", VSPercentEscapedQueryStringKeyFromStringWithEncoding([self.field description], stringEncoding), VSPercentEscapedQueryStringValueFromStringWithEncoding([self.value description], stringEncoding)];
    }
}

@end

extern NSArray * VSQueryStringPairsFromDictionary(NSDictionary *dictionary);
extern NSArray * VSQueryStringPairsFromKeyAndValue(NSString *key, id value,BOOL arrange);

static NSString * VSQueryStringFromParametersWithEncoding(NSDictionary *parameters, NSStringEncoding stringEncoding) {
    NSMutableArray *mutablePairs = [NSMutableArray array];
    for (VSQueryStringPair *pair in VSQueryStringPairsFromDictionary(parameters)) {
        [mutablePairs addObject:[pair URLEncodedStringValueWithEncoding:stringEncoding]];
    }
    
    return [mutablePairs componentsJoinedByString:@"&"];
}

NSArray * VSQueryStringPairsFromDictionary(NSDictionary *dictionary) {
    return VSQueryStringPairsFromKeyAndValue(nil, dictionary,YES);
}

NSArray * VSQueryStringPairsFromKeyAndValue(NSString *key, id value,BOOL arrange) {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = value;
        // Sort dictionary keys to ensure consistent ordering in query string, which is important when deserializing potentially ambiguous sequences, such as an array of dictionaries
        
        for (id nestedKey in (arrange?[dictionary.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]:dictionary.allKeys)) {
            id nestedValue = [dictionary objectForKey:nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:VSQueryStringPairsFromKeyAndValue((key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey), nestedValue,NO)];
            }
        }
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        for (id nestedValue in array) {
            [mutableQueryStringComponents addObjectsFromArray:VSQueryStringPairsFromKeyAndValue([NSString stringWithFormat:@"%@[]", key], nestedValue,NO)];
        }
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = value;
        for (id obj in (arrange?[set sortedArrayUsingDescriptors:@[ sortDescriptor ]]:set)) {
            [mutableQueryStringComponents addObjectsFromArray:VSQueryStringPairsFromKeyAndValue(key, obj,NO)];
        }
    } else {
        [mutableQueryStringComponents addObject:[[VSQueryStringPair alloc] initWithField:key value:value]];
    }
    
    return mutableQueryStringComponents;
}
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
                                         //[newInput addObject:obj];
                                         [newInput addObject:[self _appendedRequestObject:obj]];
                                     }else{
                                         [newInput addObject:obj];
                                     }
                                 }
                                 [arguments addObjectsFromArray:(NSArray *)newInput];
                             }
                             else if (input) {
//                                 [arguments addObject:input];
                                 [arguments addObject:[self _appendedRequestObject:input]];
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

- (SWGObject*) _appendedRequestObject:(SWGObject*)request {
    // additional body params
    NSDate *date = [NSDate date];
    float f = [date timeIntervalSince1970];
    
    NSDictionary *originDic = [request toDictionary];
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:originDic];
    [newDic setObject:@"iOS" forKey:@"app"];
    [newDic setObject:[NSString stringWithFormat:@"%.0f",f] forKey:@"time"];
    
    NSString *paramstr;
    paramstr = VSQueryStringFromParametersWithEncoding(newDic, NSUTF8StringEncoding);
    paramstr = [NSString stringWithFormat:@"%@%@",paramstr,
                @"479e32249a65c4f7b45e11254097c844"];
    NSString *sign = [paramstr md5];
    
    [newDic setObject:sign forKey:@"sign"];
    
    request = [request initWithDictionary:newDic error:nil];
    
    return request;
}
@end
