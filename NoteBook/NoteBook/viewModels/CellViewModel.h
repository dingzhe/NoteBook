//
//  CellViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "ViewModel.h"
#import "CellProperties.h"

@interface CellViewModel : ViewModel<CellProperties>

@property (nonatomic, strong, readonly) id model;
@property (nonatomic, assign, readonly) CGFloat cellWidth;

- (instancetype)initWithModel:(id )model;

- (BOOL) shouldHideCellSeperator;

/*
 * caculate layout information with cellWidth
 * @return YES, if calculated new layout; NO if use old layout info
 */
- (BOOL) layoutIfNeededWithCellWidth:(CGFloat) cellWidth;

/*
 * override to calculate layout information
 * DO NOT call this method directly.
 */
- (void) layout;


@end
