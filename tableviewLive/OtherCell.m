//
//  OtherCell.m
//  tableviewLive
//
//  Created by lkshine on 16/6/16.
//  Copyright © 2016年 lkshine. All rights reserved.
//

#import "OtherCell.h"

@implementation OtherCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void)configureForData:(NSString *)title {
    
    self.textLabel.text = title;
    
}

@end
