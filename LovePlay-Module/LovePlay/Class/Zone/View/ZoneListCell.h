//
//  ZoneListCell.h
//  LovePlay
//
//  Created by Yuns on 2017/2/3.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZoneDiscussItem;
@interface ZoneListCell : UICollectionViewCell

#pragma mark - interface
- (void)setupDiscussItem:(ZoneDiscussItem *)discussItem;

@end
