//
//  EmptyCellViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "EmptyCellViewModel.h"

@implementation EmptyCellViewModel

@dynamic model;

- (id) initWithModel:(id)model {
    if (self = [super initWithModel:model]) {
        self.cellHeight = self.model.cellHeight;
        self.selectable = self.model.selectable;
        self.seperatorHidden = self.model.seperatorHidden;
        self.seperatorInsets = self.model.seperatorInsets;
        self.contentInsets = self.model.contentInsets;
        self.backgroundColor = self.model.backgroundColor;
    }
    
    return self;
}
@end
