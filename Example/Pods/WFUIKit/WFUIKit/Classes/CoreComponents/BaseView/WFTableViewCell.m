//
//  MLTableViewCell.m
//  Loan
//
//  Created by zhangya on 17/5/5.
//  Copyright © 2017年 Shanghai Mengdian Information Technology Co., Ltd. All rights reserved.
//

#import "WFTableViewCell.h"

@implementation WFTableViewCell


- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
