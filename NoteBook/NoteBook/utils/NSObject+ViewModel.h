//
//  NSObject+ViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ViewModel)
@property (nonatomic, strong, readonly) Class viewModelClass;

// modelContext is readonly, so it can permit that only ModelProxy objects can contain 'modelContext'.
// If it is writable, there will be confusion that both NSObject and ModelProxy contain 'modelContext',
// so which one to use? It will result in chaos.
// If you want modelContext to be writable, it's time to save the value in model itself.
@property (nonatomic, strong, readonly) id modelContext;

+ (instancetype) modelWithViewModelClass:(Class)viewModelClass;

+ (instancetype) modelWithViewModelClass:(Class)viewModelClass context:(id)context;

- (instancetype) modelWithViewModelClass:(Class)viewModelClass;

- (instancetype) modelWithViewModelClass:(Class)viewModelClass context:(id)context;
@end
