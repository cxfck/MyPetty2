//
//  ActivityViewController.m
//  MyPetty
//
//  Created by apple on 14/6/25.
//  Copyright (c) 2014年 AidiGame. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActiveCell.h"
#import "ActivityDetailViewController.h"
#import "TopicListModel.h"

@interface ActivityViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
//@property (nonatomic,strong)UITableView *tableView;
//@property (nonatomic,strong)ActivityCell *tableViewCell;
@end

@implementation ActivityViewController

//- (void)dealloc
//{
//    _tableView = nil;
//    _tableViewCell = nil;
//    [super dealloc];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self createNavgation];
//    [self createTableView];
    [self loadData];
}
#pragma mark - 视图的创建
- (void)createNavgation
{
//    self.navigationController.navigationBar.alpha = 0.85;
    if (iOS7) {
        self.navigationController.navigationBar.barTintColor = BGCOLOR;
    }else{
        self.navigationController.navigationBar.tintColor = BGCOLOR;
    }
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"活动";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton * button1 = [MyControl createButtonWithFrame:CGRectMake(0, 0, 56/2, 56/2) ImageName:@"7-7.png" Target:self Action:@selector(returnClick:) Title:nil];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
}

-(void)loadData
{
    [[httpDownloadBlock alloc] initWithUrlStr:[NSString stringWithFormat:@"%@%@", TOPICLISTAPI, [ControllerManager getSID]] Block:^(BOOL isFinish, httpDownloadBlock * load) {
        if (isFinish) {
            NSLog(@"topicList:%@", load.dataDict);
            NSArray * array = [[load.dataDict objectForKey:@"data"] objectAtIndex:0];
            for (NSDictionary * dict in array) {
                TopicListModel * model = [[TopicListModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:model];
                [model release];
            }
//            self loadPhoto
            [self createTableView];
        }else{
            UIAlertView * alert = [MyControl createAlertViewWithTitle:@"活动数据请求失败"];
        }
    }];
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
}

#pragma mark - 表视图datasource和delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idetifierCell = @"cell";
    ActiveCell * _tableViewCell = [tableView dequeueReusableCellWithIdentifier:idetifierCell];
    if (_tableViewCell == nil) {
        _tableViewCell = [[[ActiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetifierCell]autorelease];
    }
    _tableViewCell.selectionStyle = 0;
    TopicListModel * model = self.dataArray[indexPath.row];
    [_tableViewCell configUI:model];
    return _tableViewCell;
    
}
//设置cellHeight
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转到活动详情页
    ActivityDetailViewController * vc = [[ActivityDetailViewController alloc] init];
    vc.listModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}


#pragma mark - 点击事件
- (void)returnClick:(UIButton *)button
{
    button.selected = !button.selected;
    JDSideMenu * menu = [ControllerManager shareJDSideMenu];
    if (button.selected) {
        [menu showMenuAnimated:YES];
    }else{
        [menu hideMenuAnimated:YES];
    }
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
