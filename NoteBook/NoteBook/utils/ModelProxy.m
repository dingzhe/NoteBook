//
//  ModelProxy.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "ModelProxy.h"

@implementation ModelProxy

+ (instancetype) modelWithModel:(id)model viewModelClass:(Class)viewModelClass {
    return [[self alloc] initWithMode:model viewModelClass:viewModelClass];
}

- (instancetype) initWithMode:(id)model viewModelClass:(Class)viewModelClass{
    _model = model;
    _viewModelClass = viewModelClass;
    
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [_model methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:_model];
}

- (BOOL)isEqual:(id)object {
    return self == object || [self.model isEqual:object];
}

- (NSUInteger) hash {
    return [self.model hash];
}

@end
