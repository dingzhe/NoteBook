//
//  CellProperties.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CellProperties <NSObject>

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) BOOL selectable;
@property (nonatomic, assign) BOOL seperatorHidden;
@property (nonatomic, assign) BOOL sectionHeader;
@property (nonatomic, assign) UIEdgeInsets seperatorInsets;
@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, strong) UIColor *backgroundColor;

@end
