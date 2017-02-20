//: Playground - noun: a place where people can play

import UIKit

var str = "1+2.3+4.3-0.6+3.33+7"


/// 获取需要运算的字符串的最后一个数字
///
/// - Parameter source: 需要运算的字符串 如："1+2.3+4.3-0.6+3.33-3.11"
/// - Returns: 返回最后一个数字
func getLastItem(source: String) -> String{
    let arr1 = source.components(separatedBy: "+")
    let arr2 = arr1.last?.components(separatedBy: "-")
    return (arr2?.last)!
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

getLastItem(source: str)
oprationResult(sourceString: str)


