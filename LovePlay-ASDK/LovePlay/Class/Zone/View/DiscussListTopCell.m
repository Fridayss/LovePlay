//
//  DiscussListTopCell.m
//  LovePlay
//
//  Created by Yuns on 2017/2/3.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussListTopCell.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "DiscussListModel.h"

@interface DiscussListTopCell ()
@property (nonatomic, strong) ASTextNode *topTextNode;
@property (nonatomic, strong) ASTextNode *titleTextNode;
@property (nonatomic, strong) ASDisplayNode *underLineNode;
@end

@implementation DiscussListTopCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"listTopCell";
    DiscussListTopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DiscussListTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

- (void)addSubNodes
{

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
