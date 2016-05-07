//
//  NBTableViewCell.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellViewModel.h"
@interface NBTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) CellViewModel *viewModel;

+ (NSString *)cellReuseIdentifier;


@end


#pragma mark -

@interface NBTableViewCell(Override)

- (void)initCell;
- (void)updateWithViewModel:(CellViewModel *)viewModel;
- (void)layoutSubviews;

@end
