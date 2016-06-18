//
//  LKTableSplitter.h
//  tableviewLive
//
//  Created by lkshine on 16/6/16.
//  Copyright © 2016年 lkshine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



//构建一个闭包配置cell内容
typedef void(^TableCellBlock) (id anyCell,id anyModel); //参数：指定的cell类，指定的模型类


@interface LKTableSplitter : NSObject <UITableViewDelegate, UITableViewDataSource>

- (id)initWithItems:(NSMutableDictionary *)anItems cellItentifier:(NSArray *)aCellIdentifier configureCellBlockArray:(NSArray *)array;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
