//
//  ModelProxy.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelProxy : NSProxy

@property (nonatomic, strong) id model;
@property (nonatomic, strong, readonly) Class viewModelClass;
@property (nonatomic, strong) id modelContext;

+ (instancetype) modelWithModel:(id)model viewModelClass:(Class)viewModelClass;


@end
