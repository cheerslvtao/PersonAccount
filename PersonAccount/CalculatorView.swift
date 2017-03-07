//
//  CalculatorView.swift
//  PersonAccount
//
//  Created by 吕涛 on 2017/2/16.
//  Copyright © 2017年 Lvtao. All rights reserved.
//

import UIKit

class CalculatorView: UIView {
    
    
    //属性观察器
    //计算结果
    var result: Double = 0.0 {
        didSet {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "calculator".hashValue)
            let topview = objc_getAssociatedObject(self, key) as! TopShowResultView
            topview.moneyLabel.text = String.init(result)
        }
    }
    
    //计算步骤
    var resultString = "0" {
        didSet {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "calculator".hashValue)
            let topview = objc_getAssociatedObject(self, key) as! TopShowResultView
            topview.operationProcess.text = resultString
        }
    }
    var isSum = true       //是否是 + 运算
    var isOpration = false //是否是运算状态

    let lineNum = 4    //列数
    let rowNum = 4     //行数
    var itemWidth: CGFloat {  //item 宽
        return UIBaseFrame.screen_width / CGFloat(lineNum)
    }
    var itemHeight: CGFloat {  //item高
        return itemWidth / 2
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        let content = [7,8,9,"←",4,5,6,"+",1,2,3,"-","C",0,".","确定"] as [Any]
        
        for i in 0..<4 {
            for j in 0..<4 {
                
                let btn = UIButton(type: .custom)
                btn.frame = CGRect(x: CGFloat(j)*(itemWidth), y: CGFloat(i)*(itemHeight), width: itemWidth, height: itemHeight)
                let btnTitle = String(describing: content[i*rowNum+j])
                btn.setTitle(btnTitle, for: .normal)
                btn.backgroundColor = UIColor.white
                btn.setTitleColor(UIColor.black, for: .normal)
                self.addSubview(btn)
                btn.addTarget(self, action: #selector(clickCalculator), for: .touchUpInside)
                btn.addTarget(self, action: #selector(clickCalculatorDown), for: .touchDown)

            }
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clickCalculatorDown(btn: UIButton) {
        btn.backgroundColor = UIBaseColor.app_main_color
    }
    
    func clickCalculator(btn: UIButton) -> Void {
        btn.backgroundColor = .white
        let value: String = (btn.titleLabel?.text)!
        let lastNumberStr = getLastItem(source: self.resultString) //最后一个数字
        let lastNumberStrComponents = lastNumberStr.components(separatedBy: ".")
        
        switch value {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            
            if lastNumberStrComponents.count == 2{
                if lastNumberStrComponents[1].characters.count >= 2 {
                    //如果小数点后已经有两位或者以上
                    break
                }
            }
            if self.resultString == "0"{
                if value == "0" { break }
                self.resultString = value
            } else {
                self.resultString += value
            }
            
            result = Double(oprationResult(sourceString: self.resultString))!
            
        case ".":
            let lastCharater = self.resultString.substring(from: self.resultString.index(before: self.resultString.endIndex))
            if  lastCharater == "+" || lastCharater == "-" {
                break
            }
            if lastNumberStrComponents.count == 1 {
                //如果数字中还没有小数点就拼接小数点 否则不做任何操作
                self.resultString += value
            }
        case "-":
            let lastCharater = self.resultString.substring(from: self.resultString.index(before: self.resultString.endIndex))
            if  lastCharater == "-" {
                break
            }
            self.resultString += value
            
        case "+":
            let lastCharater = self.resultString.substring(from: self.resultString.index(before: self.resultString.endIndex))
            if  lastCharater == "+" {
                break
            }
            self.resultString += value
            
        case "←":
            if self.resultString.characters.count == 1 {
                self.resultString = "0"
                result = 0
                break
            }
            self.resultString.remove(at: self.resultString.index(before: self.resultString.endIndex))
            result = Double(oprationResult(sourceString: self.resultString))!

        case "C":
            self.resultString = "0"
            result = 0
        case "确定":
            if resultString == "0" {
                result = 0
            }
            result = Double(oprationResult(sourceString: self.resultString))!
            self.resultString = "0"
            
        default: break
        }
        
    }

    /// 获取需要运算的字符串的最后一个数字
    ///
    /// - Parameter source: 需要运算的字符串 如："1+2.3+4.3-0.6+3.33-3.11"
    /// - Returns: 返回最后一个数字
    func getLastItem(source: String) -> String{
        let componentArr1 = source.components(separatedBy: "+")
        let componentArr2 = componentArr1.last?.components(separatedBy: "-")
        return (componentArr2?.last)!
    }
    
    
    /// 计算结果
    ///
    /// - Parameter sourceString: 需要运算的字符串 如："1+2.3+4.3-0.6+3.33-3.11"
    /// - Returns: 返回运算结果
    func oprationResult(sourceString: String) -> String {
        
        var result = 0.0
        
        var operationArr = [Any]()
        //找出运算符号所在的位置，以及类型。组成一个元组再放到数组中
        for (index, c) in sourceString.characters.enumerated() {
            if c == "-" || c == "+" {
                let tempTuples = (index, c)
                operationArr.append(tempTuples)
            }
        }
        
        //如果还没有加减运算符 直接返回原字符串
        if operationArr.count == 0 {
            return sourceString
        }
        
        //根据运算符号的位置，把运算的字符串拆开 放入数组numbers中
        var tempStartIndex = 0
        var tempEndIndex = 0
        var numbers = [String]()
        for (i, item) in operationArr.enumerated() {
            
            if tempEndIndex != 0 {
                tempStartIndex = tempEndIndex
            }
            tempEndIndex = (item as! (Int, Character)).0
            
            let range = Range.init(uncheckedBounds: (sourceString.index(sourceString.startIndex, offsetBy: tempStartIndex),sourceString.index(sourceString.startIndex, offsetBy: tempEndIndex)))
            
            let substring = sourceString.substring(with: range)
            numbers.append(substring)
            
            if i == operationArr.count - 1 {
                tempStartIndex = tempEndIndex
                let endrange = Range.init(uncheckedBounds: (sourceString.index(sourceString.startIndex, offsetBy: tempStartIndex),sourceString.index(sourceString.startIndex, offsetBy: sourceString.characters.count)))
                
                var endSubstring = sourceString.substring(with: endrange)
                
                if endSubstring == "-" || endSubstring == "+" {
                    endSubstring = "0"
                }
                numbers.append(endSubstring)
            }
        }
        
        //运算numbers中存放的数字字符串运算结果  这里没有把字符串直接转换成double类型 是因为在上面的步骤中转换后放在数组中double类型的标点后面的小数位数不可控
        for item in numbers {
            result += Double(item)!
        }
        return "\(result)"
    }

}
