//
//  BaseMacros.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/30.
//  Copyright © 2017年 yuns. All rights reserved.
//

import Foundation
import UIKit

//颜色

func RGBA(r : CGFloat, g : CGFloat, b : CGFloat, a : CGFloat) -> UIColor {
//    return UIColor.init(colorLiteralRed: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    return UIColor.init(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: a)
}

func RGB(r : CGFloat, g : CGFloat, b : CGFloat) -> UIColor {
    return RGBA(r: r, g: g, b: b, a: 1)
}
