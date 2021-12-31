//
//  StopWatchDAO.swift
//  StopWatch
//
//  Created by 신상우 on 2021/12/12.
//

import UIKit
import RealmSwift

class StopWatchDAO {
    let realm = try! Realm()
    
    func create(date: String){ // 오늘의 데이터가 없을 때 오늘 데이터를 생성하는 함수
        if let _ = self.realm.object(ofType: DailyData.self, forPrimaryKey: date) {
        } else {
            try! realm.write{
                let day = DailyData() // 오늘 데이터 생성
                day.date = date
                day.totalGoalTime = 0
                day.totalTime = 0
                let totalSeg = realm.objects(Segments.self)
                
                for seg in totalSeg {
                    let object = SegmentData() // 오늘 과목들 생성
                    object.date = date
                    object.goal = 0
                    object.value = 0
                    object.segment = seg
                    realm.add(object)
                    
                    day.dailySegment.append(object) // 오늘 데이터에 오늘 과목들 넣기
                }
                
                realm.add(day)
            }
        }
    }
    
    //과목 추가 메소드
    func addSegment(row: Int, name: String, date: String){
       
        try! realm.write{
            let segment = Segments() // 과목리스트 추가
            segment.colorRow = row
            segment.name = name
            
            realm.add(segment)
            
            let segmentData = SegmentData() // 오늘의 과목에 추가
            segmentData.date = date
            segmentData.goal = 0
            segmentData.value = 0
            segmentData.segment = segment
            
            realm.add(segmentData)
            
            let dailyData = realm.object(ofType: DailyData.self, forPrimaryKey: date) // 오늘 데이터 불러오기
        
            dailyData?.dailySegment.append(segmentData) // 오늘 데이터에 추가한 과목 추가
        }
    }

    func getSegment(date: String) {
        
    }
    
    
}

