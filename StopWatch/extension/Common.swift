//
//  extension.swift
//  StopWatch
//
//  Created by 신상우 on 2021/03/31.
//

import UIKit

extension UIViewController {
    
    //MARK: Method
    func divideSecond(timeInterval: TimeInterval) -> (String,String,String,String){
        let subSecond = Int(timeInterval / 0.01)
        let second = subSecond / 100
        let minute = second / 60
        let result = (subSecond % 100, second % 60, minute % 60,(minute / 60) % 24)
        return (returnString(result.0),returnString(result.1),returnString(result.2),returnString(result.3))
    }

    func returnString(_ integer: Int) -> String {
        let formmater = NumberFormatter()
        formmater.minimumIntegerDigits = 2
        return formmater.string(from: NSNumber(value: integer))!
    }
    //if I click anywhere in the view, the keyboard will disappear
    func hideKeyboardWhenTapped(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false //우선순위처리 아니고 하위뷰까지 제스쳐적용
        view.addGestureRecognizer(tap) //view에 제스쳐추가
    }

    @objc func dismissKeyboard(){
        self.view.endEditing(true)
}

    
    }

extension UIView {
 
    func divideSecond(timeInterval: TimeInterval) -> (String,String,String,String){
        let subSecond = Int(timeInterval / 0.01)
        let second = subSecond / 100
        let minute = second / 60
        let result = (subSecond % 100, second % 60, minute % 60,(minute / 60) % 24)
        return (returnString(result.0),returnString(result.1),returnString(result.2),returnString(result.3))
    }

    func returnString(_ integer: Int) -> String {
        let formmater = NumberFormatter()
        formmater.minimumIntegerDigits = 2
        return formmater.string(from: NSNumber(value: integer))!
    }
    
}

extension UIColor {
    class var customBrownColor:UIColor {
        get {
            return UIColor(red: 130/255, green: 84/255, blue: 52/255, alpha: 1.0)
        }
    }
    
    class var standardColor:UIColor {
        get{
            return UIColor(red: 242/255, green: 239/255, blue: 255/255, alpha: 1.0)
        }
    }
    
    class var customPurpleColor:UIColor {
        return UIColor(red: 226/255, green: 219/255, blue: 255/255, alpha: 1.0)
    }
}
//
//extension CALayer {
//    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
//        for edge in arr_edge {
//            let border = CALayer()
//            switch edge {
//            case UIRectEdge.top:
//                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
//                break
//            case UIRectEdge.bottom:
//                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
//                break
//            case UIRectEdge.left:
//                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
//                break
//            case UIRectEdge.right:
//                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
//                break
//            default:
//                break
//            }
//            border.backgroundColor = color.cgColor;
//            
//            self.addSublayer(border)
//        }
//    }
//}

extension UITextField {
    func setUnderLine(){
        let border = CALayer()
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        border.borderWidth = 1
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
