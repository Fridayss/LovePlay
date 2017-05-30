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

func RGBA(r : Float, g : Float, b : Float, a : Float) -> UIColor {
    return UIColor.init(colorLiteralRed: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func RGB(r : Float, g : Float, b : Float) -> UIColor {
    return RGBA(r: r, g: g, b: b, a: 1)
}
