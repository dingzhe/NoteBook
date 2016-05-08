//
//  EmptyCellModel.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellProperties.h"
@interface EmptyCellModel : NSObject<CellProperties>
+ (instancetype) modelWithCellHeight:(CGFloat) cellHeight
                     backgroundColor:(UIColor *) backgroundColor;

+ (instancetype) seperatorModel;
@end
