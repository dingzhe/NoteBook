//
//  FeedViewController.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBBaseViewController.h"
#import "FeedViewModel.h"
#import "NBTableViewCell.h"
#import "NBBaseViewController.h"
@interface FeedViewController : NBBaseViewController<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,retain) UITableView *tableView;

@property (nonatomic, strong) FeedViewModel *viewModel;
@property (nonatomic, copy) void(^feedDidScrollBlock)();

- (instancetype) initWithModel:(FeedViewModel *)model;

- (void) registerVSTableViewCellClass:(Class) cellClass
                forCellViewModelClass:(Class) cellViewModelClass;

- (Class) getRegisteredVSTableViewCellClassForClass:(Class) cellViewModelClass;

// override to override default global cell mapping
- (void) overrideDefaultCellMappings;

// If this method return nil, meaning no cell class is registered for corresponding cellViewModel
// Should override to create table view cell manually.
- (NBTableViewCell *) tableView:(UITableView *)tableView cellForViewModel:(CellViewModel *)cellViewModel;

- (void) tableView:(UITableView *)tableView didSelectCellWithViewModel:(CellViewModel *)cellViewModel;
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForCellWithViewModel:(CellViewModel *)cellViewModel;
- (BOOL) tableView:(UITableView *)tableView canEditCellWithViewModel:(CellViewModel *)cellViewModel;
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forCellWithViewModel:(CellViewModel *)cellViewModel;
- (NSArray*) tableView:(UITableView *)tableView editActionsForCellWithViewModel:(CellViewModel *)cellViewModel;


- (void) tableViewDidEndAsycLoading;
- (void) tableViewDidReloadData;
- (void) tableViewDidInsertSections:(NSIndexSet *)sections;
- (void) tableViewDidDeleteSections:(NSIndexSet *)sections;
- (void) tableViewDidReloadSections:(NSIndexSet *)sections;
- (void) tableViewDidInsertRowsAtIndexPaths:(NSArray *)indexPaths;
- (void) tableViewDidDeleteRowsAtIndexPaths:(NSArray *)indexPaths;
- (void) tableViewDidReloadRowsAtIndexPaths:(NSArray *)indexPaths;

- (void) showFooterViewWithImage:(NSString *)imageName seperator:(BOOL)hasSeperator;


@end
