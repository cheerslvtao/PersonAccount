//
//  AddNewInfoViewController.swift
//  PersonAccount
//
//  Created by 吕涛 on 2017/2/14.
//  Copyright © 2017年 Lvtao. All rights reserved.
//

import UIKit

class AddNewInfoViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, CAAnimationDelegate {

    var mainCollectionView: UICollectionView?
    var dataSource = [Any]()
    
    var topView = TopShowResultView()
    var calculatorV: CalculatorView?
    //计算器的显隐
    var calculatorShow: Bool = true{
        willSet {
            if newValue {
                UIView.animate(withDuration: 0.3) {
                    let frame = CGRect(x: 0, y: UIBaseFrame.screen_height - 300.0, width: UIBaseFrame.screen_width, height: 300)
                    self.calculatorV?.frame = frame
                }
                
            } else {
                UIView.animate(withDuration: 0.3) {
                    let frame = CGRect(x: -UIBaseFrame.screen_width, y: UIBaseFrame.screen_height - 300.0, width: UIBaseFrame.screen_width, height: 300)
                    self.calculatorV?.frame = frame
                }
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //顶部View
        topView = TopShowResultView(frame: CGRect(x: 0, y: 0, width: UIBaseFrame.screen_width, height: 50))
        topView.backgroundColor = .white
        self.view.addSubview(topView)

        //collectionView
        let flow = UICollectionViewFlowLayout.init()
        flow.itemSize = CGSize(width: (UIBaseFrame.screen_width-4)/5, height: UIBaseFrame.screen_width/5)
        flow.minimumInteritemSpacing = 1
        flow.minimumLineSpacing = 1
        mainCollectionView = UICollectionView(frame: CGRect(x: 0, y: 50, width: UIBaseFrame.screen_width, height: UIBaseFrame.screen_height), collectionViewLayout: flow)
        mainCollectionView?.delegate = self
        mainCollectionView?.dataSource = self
        mainCollectionView?.backgroundColor = .white
        mainCollectionView?.register(UINib(nibName: "AddNewInfoViewCell", bundle: nil), forCellWithReuseIdentifier: "AddNewInfoViewCell")
        self.view.addSubview(mainCollectionView!)
        
        //计算器
        calculatorV = CalculatorView(frame: CGRect(x: 0, y: UIBaseFrame.screen_height - 300.0 , width: UIBaseFrame.screen_width, height: 300))
        self.view.addSubview(calculatorV!)
        
        let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "calculator".hashValue)
        objc_setAssociatedObject(calculatorV, key, topView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddNewInfoViewCell", for: indexPath) as? AddNewInfoViewCell
        if indexPath.row == 9 {
            cell?.cellIcon.image = #imageLiteral(resourceName: "add")
            cell?.cellTitle.text = "编辑"

        }
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell clicked")
        collectionView.isUserInteractionEnabled = false

        let selectCell = collectionView.cellForItem(at: indexPath) as! AddNewInfoViewCell
        let starFrame = selectCell.frame
        
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        
        let path = CGMutablePath()
        let startX = starFrame.origin.x + 20
        let startY = starFrame.origin.y + 64
        path.move(to: CGPoint(x: startX, y: startY))
        path.addQuadCurve(to: CGPoint(x: 25.0, y: 25.0), control: CGPoint(x: (startX - 25)/3, y: -80))
        
        keyframeAnimation.path = path
        keyframeAnimation.duration = 0.5
        keyframeAnimation.timingFunction = CAMediaTimingFunction(name: "easeIn")
        keyframeAnimation.delegate = self
        
        
        let animView = UIImageView()
        animView.frame.size = selectCell.cellIcon.bounds.size
        animView.frame.origin = CGPoint(x: startX, y: startY)
        
        self.view.addSubview(animView)
        animView.image = selectCell.cellIcon.image
    
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) { 
            self.topView.headerImageView.image = selectCell.cellIcon.image
            self.topView.typeLabel.text = selectCell.cellTitle.text
            animView.removeFromSuperview()
            animView.layer.removeAnimation(forKey: "selectCell")
            self.mainCollectionView?.isUserInteractionEnabled = true

        }
        
        animView.layer.add(keyframeAnimation, forKey: "selectCell")
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !calculatorShow  { calculatorShow = true }
    }

}


//顶部显示组件
class TopShowResultView: UIView {
    var headerImageView: UIImageView //左侧图片
    var typeLabel: UILabel  //类型
    var moneyLabel: UILabel //金额
    var operationProcess: UILabel //计算过程显示
    
    var moneyChanged: (result: Double, process: String) = (0, ""){
        willSet {
            moneyLabel.text = String(moneyChanged.result)
            operationProcess.text = moneyChanged.process
        }
    }
    
    override init(frame: CGRect) {
        headerImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30 ))
        headerImageView.image = #imageLiteral(resourceName: "tabbar_zhi_s")
        
        typeLabel = UILabel(frame: CGRect(x: 50, y: 10, width: 80, height: 30 ))
        typeLabel.text = "支付宝"
        
        moneyLabel = UILabel(frame: CGRect(x: 140, y: 10, width: UIBaseFrame.screen_width-10-140, height: 25 ))
        moneyLabel.textAlignment = .right
        moneyLabel.text = "0"
        moneyLabel.font = UIFont.systemFont(ofSize: 21)
        
        operationProcess = UILabel(frame: CGRect(x: 140, y: 35, width: UIBaseFrame.screen_width-10-140, height: 15 ))
        operationProcess.textAlignment = .right
        operationProcess.text = "0"
        operationProcess.font = UIFont.systemFont(ofSize: 10)
        operationProcess.textColor = UIColor.gray
        
        super.init(frame: frame)
        self.addSubview(headerImageView)
        self.addSubview(typeLabel)
        self.addSubview(moneyLabel)
        self.addSubview(operationProcess)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




