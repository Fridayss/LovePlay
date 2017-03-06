//
//  BaseMacros.h
//  LovePlay
//
//  Created by Yuns on 2017/2/13.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#ifndef BaseMacros_h
#define BaseMacros_h

//颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define RandomRGB RGB(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

//打印
#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

#endif /* BaseMacros_h */
