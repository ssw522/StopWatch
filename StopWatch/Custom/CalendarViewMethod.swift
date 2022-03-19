//
//  CalendarViewMethod.swift
//  StopWatch
//
//  Created by 신상우 on 2022/03/17.
//

import UIKit

class CalendarMethod {
    // 날짜 년,월,일로 쪼개서 반환
    func splitDate(date: String) -> (String,String,String) {
        let split = date.split(separator: ".")
        let year = String(split[0])
        let month = String(split[1])
        let day = String(split[2])
        
        return (year,month,day)
    }
    
    func splitDate(date: String) -> (Int,Int,Int) {
        let split = date.split(separator: ".")
        let year = Int(split[0]) ?? 0
        let month = Int(split[1]) ?? 0
        let day = Int(split[2]) ?? 0
        
        return (year,month,day)
    }
    
    // 달 바꾸는 메소드
    func changeMonth(tag: Int,date: String) -> (Int,Int,Int) {
        var year =  Int(self.splitDate(date: date).0)!
        var month = Int(self.splitDate(date: date).1)!
        let day = Int(self.splitDate(date: date).2)!
        
        switch tag {
        case 0: // previous button
            if month == 1 {
                year -= 1
                month = 12
            }else{
                month -= 1
            }
            break
        case 1: // next button
            if month == 12 {
                year += 1
                month = 1
            }else{
                month += 1
            }
            break
        default:
            return (year,month,day)
        }
        
        return (year,month,day)
    }
    
    //요일 변화 메소드
    func convertDate(date: String)-> String{
        var (year,month,_):(String,String,String) = CalendarMethod().splitDate(date: date)
        var monthWord = ""
        year.removeFirst()
        year.removeFirst()
        
        switch month {
        case "01": monthWord = "January"
        case "02": monthWord = "February"
        case "03": monthWord = "March"
        case "04": monthWord = "April"
        case "05": monthWord = "May"
        case "06": monthWord = "June"
        case "07": monthWord = "July"
        case "08": monthWord = "August"
        case "09": monthWord = "September"
        case "10": monthWord = "October"
        case "11": monthWord = "November"
        case "12": monthWord = "December"
        default:
            print("error")
        }
        
        return year + " " + monthWord
    }
}
