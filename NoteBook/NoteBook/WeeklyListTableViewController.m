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
#import "WeeklyListTableViewCell.h"
@interface WeeklyListTableViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) RACCommand *weeklyListCommand;
@property (nonatomic, strong) SWGWeeklyListResponses *weeklyListResponses;
@property (nonatomic, strong) NSArray *count;
@end

@implementation WeeklyListTableViewController



- (instancetype)init{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        @weakify(self)
        _weeklyListCommand = [NoteBookWeeklyService.service weeklyListCommandEnable:nil];
        
        [_weeklyListCommand.responses subscribeNext:^(SWGWeeklyListResponses *response) {
            @strongify(self)
            //            [self.showHUDSignal sendNext:@"保存成功"];
            _weeklyListResponses = response;
            NSLog(@"%@",response);
            _count = [self modelsFromResponse:response];
            [[self tableView] reloadData];
        }];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"weekly";
    [self weeklyList];
    self.view.backgroundColor = [UIColor colorWithRed:240./255. green:255./255. blue:240./255. alpha:1.];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[WeeklyListTableViewCell class] forCellReuseIdentifier:@"WeeklyListCell"];
    
    
    
}
- (void)weeklyList{
    SWGWeeklyListRequest *request = [[SWGWeeklyListRequest alloc] init];
    request.uid = @"9";
    [_weeklyListCommand execute:request];
}
- (NSArray *) modelsFromResponse:(SWGWeeklyListResponses *)response {
    NSMutableArray *modelAry = [NSMutableArray array];
    
    [response.data enumerateObjectsUsingBlock:^(SWGWeekly *obj, NSUInteger idx, BOOL *stop) {
        [modelAry addObject:obj];
    }];
    
    return modelAry;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    
    return _count.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"WeeklyListCell" forIndexPath:indexPath];
    
    SWGWeekly * model = _count[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.content;
    return cell;
}


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
