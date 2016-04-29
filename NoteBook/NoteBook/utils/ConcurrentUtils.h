//
//  ConcurrentUtils.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ASYNC_BEGIN(queue) \
dispatch_async((queue), ^{

#define ASYNC_MAIN_BEGIN \
dispatch_async(dispatch_get_main_queue(), ^{

#define ASYNC_MAIN_END \
});

#define ASYNC_END \
});

