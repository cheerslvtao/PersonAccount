//
//  AccountDetailViewController.swift
//  PersonAccount
//
//  Created by 吕涛 on 2017/2/14.
//  Copyright © 2017年 Lvtao. All rights reserved.
//

import UIKit

class AccountDetailViewController: BaseViewController , UITableViewDelegate , UITableViewDataSource {
    
    var mainTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置导航rightItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "nav_editing"), style: .plain, target: self, action: #selector(editingAccountBookInfo))
        
        self.mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIBaseFrame.screen_width, height: UIBaseFrame.screen_height-64-48), style: .plain)
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.separatorStyle = .none
        let nib = UINib(nibName: "AccountDetailCell", bundle: nil)
        self.mainTableView.register(nib, forCellReuseIdentifier: "AccountDetailCell")
        self.view .addSubview(self.mainTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountDetailCell", for: indexPath) as! AccountDetailCell
        return cell
    }

    
    
    
    /// 编辑信息
    func editingAccountBookInfo() {
        print("editing")
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
