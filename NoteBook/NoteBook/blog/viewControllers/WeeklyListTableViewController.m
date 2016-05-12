//
//  WeeklyListTableViewController.m
//  
//
//  Created by dz on 16/1/9.
//
//

#import "WeeklyListTableViewController.h"
#import "ViewController.h"
#import "NoteBookLib.h"
#import "MKMarkdownController.h"
#import "MKPreviewController.h"
#import "FeedViewController+Refresh.h"
#import "WeeklyListCellViewModel.h"
#import "UIView+HUD.h"

@interface WeeklyListTableViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) RACCommand *favoriteBlogCommand;
@property (nonatomic, strong) RACCommand *delWeeklyCommand;
@property (nonatomic, strong) RACCommand *updateWeeklyCommand;

@property (nonatomic, strong) SWGWeeklyListResponses *weeklyListResponses;
@property (nonatomic, strong) NSMutableArray *count;
@end

@implementation WeeklyListTableViewController
@dynamic viewModel;

+ (instancetype) viewController {
    WeeklyListTableViewController *result = [[self alloc] initWithModel:[WeeklyListTableViewModel viewModel]];
    result.navBackBarButtonHidden = YES;
    return result;
}
- (instancetype) initWithModel:(WeeklyListTableViewModel *)model {
    self = [super initWithModel:model];
    if (self) {
//        _selectedSignal = [RACSubject subject];
        _favoriteBlogCommand = [NoteBookWeeklyService.service favoriteBlogCommandEnable:nil];
        @weakify(self)
        [_favoriteBlogCommand.responses subscribeNext:^(SWGFavoriteBlogResponses *response) {
            @strongify(self)
//            [self.viewModel showHUDMessage:response.message];
            if (response.code.integerValue == 200) {
                [self.navigationController.view showHUDWithText:nil detailText:response.message autoDismiss:YES];
            }else{
                [self.navigationController.view  showHUDWithText:nil detailText:@"收藏失败" autoDismiss:YES];
            
            }
            
        }];
        [_favoriteBlogCommand.errors subscribeNext:^(NSError *error) {
            [self.navigationController.view  showHUDWithText:nil detailText:@"收藏失败" autoDismiss:YES];
            
        }];
    }
    return self;
}
- (void)FavoriteBlog:(SWGWeekly *)model{
    SWGFavoriteBlogRequest *request = [[SWGFavoriteBlogRequest alloc] init];
    request.uid = UserModel.currentUser.uid;
    request.weeklyid = model.weeklyid;
    [_favoriteBlogCommand execute:request];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"博客";
    [self.view setBackgroundColor:[UIColor whiteColor]];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onPreview:)];
    
    
    
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"test"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                 action:@selector(openTestView)];
    [self addFreshingControls];
    [self.viewModel loadAtHead];
}
- (void) tableView:(UITableView *)tableView didSelectCellWithViewModel:(CellViewModel *)cellViewModel {
    if ([cellViewModel isKindOfClass:WeeklyListCellViewModel.class]) {
        
        SWGWeekly * model = (SWGWeekly*)cellViewModel.model;
//        MKMarkdownController *controller = [[MKMarkdownController alloc] initWithModel:model];
//        controller.defaultMarkdownText   = model.content;
        
        MKPreviewController *previewController = MKPreviewController.new;
        previewController.bodyMarkdown = model.content;
//        [previewController ]
        previewController.type = MKPreviewControllerBlog;
        previewController.title = model.title;
        @weakify(self) //@strongify(self)
        previewController.onclickBarBtn  = ^(UIBarButtonItem *item){
            if ([item.title isEqualToString:@"收藏"]) {
                @strongify(self)
                [self FavoriteBlog:model];
                NSLog(@"weeklyid:%@",model.weeklyid);
            }else if([item.title isEqualToString:@"分享"]){
                NSLog(@"weeklyid:%@",model.weeklyid);
            }
        };

        
        
        
        
        
        
//        previewController.onComplete   = self.onComplete;
        [self.navigationController pushViewController:previewController
                                             animated:YES];
        
        
//        controller.onComplete = ^(UIViewController *c)
//        {
//            MKPreviewController *pc = (MKPreviewController *) c;
//            NSLog(@"%@", pc.bodyMarkdown);
//            [c dismissViewControllerAnimated:YES completion:nil];
//        };
//        [self.navigationController pushViewController:controller animated:YES];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
//        [self presentViewController:nav animated:YES completion:nil];
//        [self.navigationController pushViewController:nav animated:YES];
        
        
    }
}

//- (instancetype)init{
//    self = [super initWithStyle:UITableViewStylePlain];
//    if (self) {
//        @weakify(self)
//        _weeklyListCommand = [NoteBookWeeklyService.service weeklyListCommandEnable:nil];
//        
//        [_weeklyListCommand.responses subscribeNext:^(SWGWeeklyListResponses *response) {
//            @strongify(self)
//            //            [self.showHUDSignal sendNext:@"保存成功"];
//            _weeklyListResponses = response;
//            NSLog(@"%@",response);
//            _count = [self modelsFromResponse:response];
//            [[self tableView] reloadData];
//        }];
//        _delWeeklyCommand = [NoteBookWeeklyService.service delWeeklyCommandEnable:nil];
//        [_delWeeklyCommand.responses subscribeNext:^(SWGResponses *response) {
//            @strongify(self)
//            [[self tableView] reloadData];
//        }];
//        _updateWeeklyCommand = [NoteBookWeeklyService.service updateWeeklyCommandEnable:nil];
//        [_updateWeeklyCommand.responses subscribeNext:^(SWGResponses *response) {
//            @strongify(self)
//            [[self tableView] reloadData];
//        }];
//        
//    }
//    return self;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.title = @"weekly";
//    [self weeklyList];
//    self.view.backgroundColor = [UIColor colorWithRed:240./255. green:255./255. blue:240./255. alpha:1.];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.tableView registerClass:[WeeklyListTableViewCell class] forCellReuseIdentifier:@"WeeklyListCell"];
//
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onPreview:)];
//    
//    
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"test"
//                                                                             style:UIBarButtonItemStylePlain
//                                                                            target:self
//                                                                            action:@selector(openTestView)];
//    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
//    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
//    refresh.tintColor = [UIColor blueColor];
//    [refresh addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
//    self.refreshControl = refresh;
//    
//}
- (void)openTestView{
    ViewController *testVC = [ViewController viewController];
    [self.navigationController pushViewController:testVC animated:YES];
    
}
- (void)onPreview:(id)onClick
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"syntax" ofType:@"md"];
    NSString *content  = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    MKMarkdownController *controller = [[MKMarkdownController alloc] initWithAddNote];
    controller.defaultMarkdownText   = content;
    controller.onComplete = ^(UIViewController *c)
    {
        MKPreviewController *pc = (MKPreviewController *) c;
        NSLog(@"%@", pc.bodyMarkdown);
        [c dismissViewControllerAnimated:YES completion:nil];
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav
                       animated:YES
                     completion:nil];
}
//- (void)pullToRefresh
//{
//    //模拟网络访问
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中"];
//    [self weeklyList];
//    double delayInSeconds = 0.5;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
////        _rowCount += 5;
//        [self.tableView reloadData];
//        //刷新结束时刷新控件的设置
//        [self.refreshControl endRefreshing];
//        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
//        
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
////        _bottomRefresh.frame = CGRectMake(0, 44+_rowCount*RCellHeight, 320, RCellHeight);
//    });
//}
//
//- (void)weeklyList{
//    SWGWeeklyListRequest *request = [[SWGWeeklyListRequest alloc] init];
//    request.uid = UserModel.currentUser.uid;
//    [_weeklyListCommand execute:request];
//}
//- (void)delWeekly:(NSString *)weeklyid {
//    SWGDelWeeklyRequest *request = [[SWGDelWeeklyRequest alloc] init];
//    request.weeklyid = weeklyid;
//    request.uid = UserModel.currentUser.uid;
//    [_delWeeklyCommand execute:request];
//}
//
//
//- (NSArray *) modelsFromResponse:(SWGWeeklyListResponses *)response {
//    NSMutableArray *modelAry = [NSMutableArray array];
//    
//    [response.data enumerateObjectsUsingBlock:^(SWGWeekly *obj, NSUInteger idx, BOOL *stop) {
//        [modelAry addObject:obj];
//    }];
//    
//    return modelAry;
//}
//
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    
//    return _count.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 1;
//}
//
//
//
//
//
//- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}
//- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
//    
////    [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]
//    
//    
//    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
//    
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"WeeklyListCell" forIndexPath:indexPath];
//    
//    SWGWeekly * model = _count[indexPath.section];
//    cell.textLabel.text = model.title;
//    cell.detailTextLabel.text = model.content;
//    return cell;
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//
//    [self pullToRefresh];
//    
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    SWGWeekly * model = _count[indexPath.section];
//    MKMarkdownController *controller = [[MKMarkdownController alloc] initWithModel:model];
//    controller.defaultMarkdownText   = model.content;
//    controller.onComplete = ^(UIViewController *c)
//    {
//        MKPreviewController *pc = (MKPreviewController *) c;
//        NSLog(@"%@", pc.bodyMarkdown);
//        [c dismissViewControllerAnimated:YES completion:nil];
//    };
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
//    [self presentViewController:nav animated:YES completion:nil];
////    [self.navigationController pushViewController:controller animated:YES];
//
//}
//
//
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle==UITableViewCellEditingStyleDelete) {
//        //        获取选中删除行索引值
////        NSInteger row = [indexPath row];
//        //        通过获取的索引值删除数组中的值
//        SWGWeekly * model = _count[indexPath.section];
//        [self delWeekly:model.weeklyid];
//        
//        [self.count removeObjectAtIndex:indexPath.section];
//        [self.tableView reloadData];
//        //        删除单元格的某一行时，在用动画效果实现删除过程
//        //[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
