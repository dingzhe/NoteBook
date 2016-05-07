//
//  NSObject+ViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NSObject+ViewModel.h"
#import "ModelProxy.h"

@implementation NSObject (ViewModel)
@dynamic viewModelClass;
- (Class) viewModelClass {
    // alwasy return nil for non-ModelProxy object
    return nil;
}

@dynamic modelContext;
- (id) modelContext {
    // alwasy return nil for non-ModelProxy object
    return nil;
}

+ (instancetype) modelWithViewModelClass:(Class)viewModelClass {
    return [self modelWithViewModelClass:viewModelClass context:nil];
}

+ (instancetype) modelWithViewModelClass:(Class)viewModelClass context:(id)context {
    return [[NSObject new] modelWithViewModelClass:viewModelClass context:context];
}

- (instancetype) modelWithViewModelClass:(Class)viewModelClass {
    return [self modelWithViewModelClass:viewModelClass context:nil];
}

- (instancetype) modelWithViewModelClass:(Class)viewModelClass context:(id)context {
    ModelProxy *result = [ModelProxy modelWithModel:self viewModelClass:viewModelClass];
    result.modelContext = context;
    return (NSObject *)result;
}

@end
