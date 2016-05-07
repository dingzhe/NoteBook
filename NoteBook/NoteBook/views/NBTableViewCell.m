//
//  NBTableViewCell.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBTableViewCell.h"
#import "AFNetworking.h"

@interface NBTableViewCell()

@property (nonatomic, strong) RACDisposable *disposable;

@end

@implementation NBTableViewCell
@synthesize viewModel = _viewModel;
@synthesize disposable = _disposable;
- (void) setDisposable:(RACDisposable *)disposable {
    if (_disposable) {
        [_disposable dispose];
        [self.rac_deallocDisposable removeDisposable:_disposable];
    }
    
    _disposable = disposable;
    
    if (_disposable) {
        [self.rac_deallocDisposable addDisposable:_disposable];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initCell];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initCell];
    }
    return self;
}

- (void) awakeFromNib {
    [self initCell];
}

- (void)initCell {
}

- (void)updateWithViewModel:(CellViewModel *)viewModel {
    _viewModel = viewModel;
    
    self.disposable = nil;
    
    if (_viewModel) {
        @weakify(self)
        
        self.disposable = \
        [[_viewModel.needsLayoutSignal deliverOn:RACScheduler.mainThreadScheduler]
         subscribeNext:^(id _) {
             @strongify(self)
             
             [self setNeedsLayout];
         }];
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass(self);
}
@end
