//
//  RootTabBarViewController.swift
//  PersonAccount
//
//  Created by 吕涛 on 2017/2/14.
//  Copyright © 2017年 Lvtao. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false  //避免受默认的半透明色影响，关闭
        self.tabBar.tintColor = UIBaseColor.app_main_color //设置选中颜色，这里使用黄色
        
        var vcArr = [UIViewController]()
        var itemTitles = ["账单","新增","图表"]
        let imgNameArr = ["tabbar_book","tabbar_add","tabbar_view"]

        for (index, obj) in getClassInfo().enumerated()  {
            let object = obj as! UIViewController
            let nav = UINavigationController.init(rootViewController: object)
            object.title = itemTitles[index]
            vcArr.append(nav)
            
            let image = UIImage.init(named: imgNameArr[index])?.withRenderingMode(.alwaysOriginal)
            let selectImage = UIImage.init(named: imgNameArr[index] + "_s")?.withRenderingMode(.alwaysOriginal)
            
            object.tabBarItem = UITabBarItem.init(title: itemTitles[index], image: image, selectedImage: selectImage)

        }
        
        self.viewControllers = vcArr
    
    }
    
    //获取控制器信息
    func getClassInfo() -> [AnyObject] {
        var classArr = [AnyObject]()
        let accountDetailVC = AccountDetailViewController()
        let addNewInfoVC = AddNewInfoViewController()
        let ChartVC = ChartViewController()
        classArr.append(accountDetailVC)
        classArr.append(addNewInfoVC)
        classArr.append(ChartVC)
        return classArr
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
