//
//  IconTextCellModel.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IconTextCellModel : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *iconName;

+ (instancetype) modelWithText:(NSString *) text iconName:(NSString *)iconName;

@end
