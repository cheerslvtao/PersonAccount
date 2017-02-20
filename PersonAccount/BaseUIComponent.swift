//
//  BaseUIComponent.swift
//  PersonAccount
//
//  Created by 吕涛 on 2017/2/14.
//  Copyright © 2017年 Lvtao. All rights reserved.
//

import Foundation
import UIKit


struct UIBaseFrame {
    //类型只读计算属性
    static var screen_width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    static var screen_height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    static var screen_bounce: CGRect {
        return UIScreen.main.bounds
    }
}

struct UIBaseColor {
    static var app_main_color: UIColor {
        return UIColor.init(red: 155/255.0, green: 228/255.0, blue: 178/255.0, alpha: 1)
    }
}
