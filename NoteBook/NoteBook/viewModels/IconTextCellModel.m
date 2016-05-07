//
//  IconTextCellModel.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "IconTextCellModel.h"

@implementation IconTextCellModel

+ (instancetype) modelWithText:(NSString *) text iconName:(NSString *)iconName {
    IconTextCellModel *result = [IconTextCellModel new];
    
    result.text = text;
    result.iconName = iconName;
    
    return result;
}

@end
