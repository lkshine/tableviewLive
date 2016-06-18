//
//  LKTableSplitter.m   --- tableview的分离器
//  tableviewLive
//
//  Created by lkshine on 16/6/16.
//  Copyright © 2016年 lkshine. All rights reserved.
//

#import "LKTableSplitter.h"
#import "MyCell.h"
#import "OtherCell.h"



@interface LKTableSplitter()

@property (nonatomic, strong) NSMutableDictionary   * items;          //tableview所有内容数据
@property (nonatomic, copy  ) NSArray        * cellIdentifier; //多种cell的ID
@property (nonatomic, copy  ) TableCellBlock   fCellBlock;
@property (nonatomic, copy  ) TableCellBlock   sCellBlock;

@end



@implementation LKTableSplitter

- (id)init {
    
    return nil;
}

- (id)initWithItems:(NSMutableDictionary *)anItems cellItentifier:(NSArray *)aCellIdentifier configureCellBlockArray:array {
    
    self = [super init];
    if (self) {
        
        self.items          = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.fCellBlock     = [array[0] copy];
        self.sCellBlock     = [array[1] copy];
    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section) {
        
        return [[self.items valueForKey:@"second"] objectAtIndex:indexPath.row];
    }
    else {
        
        return [[self.items valueForKey:@"first"] objectAtIndex:indexPath.row];
    }
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.items allKeys].count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section) {
        
        return [[self.items valueForKey:@"second"] count];
    }
    else {
        
        return [[self.items valueForKey:@"first"] count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section) {
        
        OtherCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier[indexPath.section] ];

        if (cell== nil) {
            
            cell = [[OtherCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier[indexPath.section]];
        }
        
        id  item = [self itemAtIndexPath:indexPath]; //拿到对应行数据
        self.sCellBlock(cell, item);                 //数据图像化
        
        return cell;
    }
    else {
        
        MyCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier[indexPath.section]];
        
        if (cell== nil) {
            
            cell = [[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier[indexPath.section]];
        }
        
        id  item = [self itemAtIndexPath:indexPath];
        self.fCellBlock(cell, item);
        
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section) {
        
        NSLog(@"\n\t🚩\n secondRow = %@ \n\t📌", [self.items valueForKey:@"second"] [indexPath.row]);
    }
    else {
        
        NSLog(@"\n\t🚩\n firstRow = %@ \n\t📌", [self.items valueForKey:@"first"] [indexPath.row]);
    }
    
}


//开始编辑前调用
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%s", __func__);
}

//完成编辑调用
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%s", __func__);
}


- (nullable NSArray <UITableViewRowAction *>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction * action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更新" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [tableView reloadData];
    }];
    
    UITableViewRowAction * action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        
        NSMutableArray * arr = [NSMutableArray new];
        if (indexPath.section) {
            
            arr = [NSMutableArray arrayWithArray:[self.items valueForKey:@"second"]];
            [arr removeObjectAtIndex:indexPath.row];
            [self.items setValue:arr forKey:@"second"];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            
        }
        else {
            
            arr = [NSMutableArray arrayWithArray:[self.items valueForKey:@"first"]];
            [arr removeObjectAtIndex:indexPath.row];
            [self.items setValue:arr forKey:@"first"];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        }
        
//        [tableView reloadData];
    }];
    
    NSArray * actionArray = @[action1, action2];
    
    return actionArray;
}

#pragma mark - 单元格移动

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    
    NSLog(@"%s",__func__);
//    //取出Cell的数据源
//    NumberGroup *sourceGroup = self.dataList[sourceIndexPath.section];
//    //取出对应的Cell
//    Number *sourceNumber = sourceGroup.groupNumbers[sourceIndexPath.row];
//    //删除cell对应的数据源
//    [sourceGroup.groupNumbers removeObjectAtIndex:sourceIndexPath.row];
//    //取出新Group
//    NumberGroup *descGroup = self.dataList[destinationIndexPath.section];
//    //插入新位置
//    [descGroup.groupNumbers insertObject:sourceNumber atIndex:destinationIndexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    view.backgroundColor = [UIColor redColor];
    return  view;
}



@end



