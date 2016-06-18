//
//  MyCell.m
//  tableviewLive
//
//  Created by lkshine on 16/6/16.
//  Copyright © 2016年 lkshine. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configureForData:(NSString *)title {
    
    self.textLabel.text = title;
    
}


@end
