//
//  UIView+Extension.swift
//  LovePlay
//
//  Created by Yuns on 2017/5/20.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

extension UIView {
    public var height : CGFloat {
        set {
            var newFrame = self.frame
            newFrame.size.height = newValue
            self.frame = newFrame
        }
        
        get {
            return self.frame.size.height
        }
    }
    
    public var width : CGFloat {
        set {
            var newFrame = self.frame
            newFrame.size.width = newValue
            self.frame = newFrame
        }
        
        get {
            return self.frame.size.width
        }
    }
}
