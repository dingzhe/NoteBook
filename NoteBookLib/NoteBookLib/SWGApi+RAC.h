//
//  SWGApi+RAC.h
//  NoteBookLib
//
//  Created by dz on 15/11/24.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import "noteApiSDK/SWGApi.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface SWGApi (RAC)
- (RACCommand *) commandWithSelector:(SEL)selector enabled:(RACSignal *)enabled;

@end
