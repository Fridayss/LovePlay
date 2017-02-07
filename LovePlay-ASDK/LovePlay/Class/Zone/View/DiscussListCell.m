//
//  DiscussListCell.m
//  LovePlay
//
//  Created by Yuns on 2017/2/3.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussListCell.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "DiscussListModel.h"

@interface DiscussListCell ()
@property (nonatomic, strong) UILabel *titleTextNode;
@end

@implementation DiscussListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"listCell";
    DiscussListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DiscussListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setListModel:(DiscussListModel *)listModel
{
    _listModel = listModel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}


@end
