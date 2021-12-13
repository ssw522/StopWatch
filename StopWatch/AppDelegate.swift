//
//  AppDelegate.swift
//  StopWatch
//
//  Created by 신상우 on 2021/03/23.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var saveDate: String { // 오늘 날짜 반환!
        return self.date()
    }
    
    var totalTime: TimeInterval {
            //DB에서 전체시간 리턴
            return realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)?.totalTime ?? 0
    }
    
    var totalGoalTime: TimeInterval {
            //DB에서 전체시간 리턴
            return realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)?.totalGoalTime ?? 0
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: StopWatchViewController())
        window?.makeKeyAndVisible()
        
        //DB 아무것도 없을 때 기본 과목 설정.
        func setFirstDB(){
            try! realm.write{
                if realm.objects(Segments.self).count == 0 {
                    let data = Segments()
                    data.colorRow = 17
                    data.name = "기타"
                    
                    realm.add(data)
                }
            }
        }
        
        return true
    }
    
    //오늘 날짜 리턴 메소드
    func date() -> String{
        let date = DateFormatter()
        date.locale = Locale(identifier: Locale.current.identifier)
        date.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        date.dateFormat = "YYYY. MM. dd"
        
        return date.string(from: Date())
    }
}

