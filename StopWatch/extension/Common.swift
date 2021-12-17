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
    
    // CalendarMethod
    
    func isLeapYear(year: Int) -> Bool {
        if (year%4 == 0 && year%100 != 0) || year%400 == 0{
            return true //4로 떨어지고 100으로 안떨어지거나 400으로 떨어지면 윤년
        }else{ return false } //아니면 평년
    }


    func getFirstDay(year: Int, month: Int, day: Int) -> Int {
        let first = (year-1) / 400 // 400으로 떨어진건 무조건 윤년.
        let second = (year-1) / 100 - first //100으로 나눈 수는 평년 그러나 400으로 나눈건 윤년이니까 빼준다.
        let leapYear =  (year-1) / 4 - second // 4로 떨어진 수에 100으로 떨어진 수를 빼면 윤년
        var days = (year - 1) * 365 + leapYear + 1 // 1년 1월 1일 기준 월요일로 잡고 월요일값 1에 일 수 만큼 더한 후 7로 나누어 그 해 첫 요일 값을 구한다.
        
        var monthDay = 0
        
        for i in 1..<month {
            monthDay += getMonthDay(year: year, month: i)
        }
        days += monthDay

        return days % 7
    }

    func getMonthDay(year: Int, month: Int) -> Int {
        switch month {
        case 4 : fallthrough
        case 6 : fallthrough
        case 9 : fallthrough
        case 11 : return 30
            
        case 2 :
            if isLeapYear(year: year) {
                return 29
            }else { return 28 }
            
        default:
            return 31
        }
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
