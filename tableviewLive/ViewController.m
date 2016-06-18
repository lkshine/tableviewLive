//
//  ViewController.m
//  tableviewLive
//
//  Created by lkshine on 16/6/16.
//  Copyright © 2016年 lkshine. All rights reserved.
//

#import "ViewController.h"

#import "MyCell.h"
#import "OtherCell.h"
#import "LKTableSplitter.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) LKTableSplitter * dataSource;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableDictionary * mDicData;
@end

@implementation ViewController

- (NSMutableDictionary *)mDicData {
    
    if (!_mDicData) {
        
        _mDicData = [NSMutableDictionary dictionaryWithDictionary:@{@"first":@[@"sdf", @"qqe", @"xcv", @"hgre", @"uiop", @"jkhk"], @"second":@[@"2sdf", @"3qqe", @"1xcv", @"5hgre"]}];
        NSLog(@"\n\t🚩\n _mDicData = %@ \n\t📌", _mDicData);
    }
    
    return _mDicData;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    _tableView.backgroundColor = [UIColor cyanColor];
//    _tableView.delegate = self;
    
    //为初始化列表的数据源声明一个block
    TableCellBlock fCnfigureBlock = ^(MyCell *cell, NSString * titile) {
        
        [cell configureForData:titile];
    };
    
    TableCellBlock sConfigureBlock = ^(OtherCell * cell, NSString * titile) {
        
        [cell configureForData:titile];
    };
    
    NSArray * arr         = @[fCnfigureBlock, sConfigureBlock];

    //初始化列表的数据源
    _dataSource           = [[LKTableSplitter alloc]initWithItems:self.mDicData cellItentifier:@[@"FID", @"SID"] configureCellBlockArray:arr];

    _tableView.dataSource = _dataSource;
    _tableView.delegate   = _dataSource;
    
    //把列表添加到View上
    [self.view addSubview:_tableView];

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"offset---scroll:%f", _tableView.contentOffset.y);
    UIColor * color = [UIColor redColor];
    CGFloat offset  = scrollView.contentOffset.y;
    
    if (offset < 0) {
        
        self.navigationController.navigationBar.backgroundColor = [color colorWithAlphaComponent:0];
    }
    else {
        
        CGFloat alpha = 1-((64-offset)/64);
        self.navigationController.navigationBar.backgroundColor = [color colorWithAlphaComponent:alpha];
    }
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end

