//
//  AppStyleManager.swift
//  PersonAccount
//
//  Created by 吕涛 on 2017/2/14.
//  Copyright © 2017年 Lvtao. All rights reserved.
//


///  管理 APP 的 style 样式
import UIKit

class appStyle: NSObject {
    
    static func appDefaultStyle() {
        let navigation = UINavigationBar.appearance()
        let navgationBgImg = UIImage.init(named: "nav_bgImg")?.withRenderingMode(.alwaysOriginal)
        navigation.setBackgroundImage(navgationBgImg, for: .default)
        navigation.tintColor = UIColor.white
        navigation.barStyle = .black
    }
    
    
}
