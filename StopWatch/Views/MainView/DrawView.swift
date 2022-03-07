//
//  DrawView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/04/11.
//

import UIKit
import RealmSwift

class DrawView: UIView {
    //MARK: properties
    var saveDate = ""
    var total: TimeInterval = 0.0
    lazy var radius = min(self.frame.width, self.frame.height) * 0.40
    let realm = try! Realm()
    
    private lazy var textAttributes : [NSAttributedString.Key : Any] = {
        return [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func date() -> String{
        let date = DateFormatter()
        date.locale = Locale(identifier: Locale.current.identifier)
        date.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        date.dateFormat = "YYYY.MM.dd"
        
        return date.string(from: Date())
    }
    
    //MARK: Draw
    override func draw(_ rect: CGRect) {
        let filter = self.realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)
        let segment = filter!.dailySegment
        self.total = segment.reduce(0){
            (result,segment) in
            return segment.value + result
        }
            
            let center = CGPoint(x: rect.midX, y: rect.midY)
            var endAngle: CGFloat = 0.0
            var startAngle: CGFloat = ((-.pi) / 2)
            
            segment.forEach(){(segment) in //각 카테고리별로 그래프 그리기!
                let colorCode = segment.segment!.colorCode
                let color = uiColorFromHexCode(colorCode)
                
                let ratioTime = CGFloat(segment.value / self.total)
                endAngle = startAngle + (ratioTime * (.pi * 2))
               
                let path = UIBezierPath()
                path.move(to: center)
                path.addArc(withCenter: center, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                
                color.setFill()
                path.fill()
                // divide line stroke
                UIColor.white.setStroke()
                path.lineWidth = 2
                path.close()
                path.stroke()
                
                if ratioTime > 0.09 { // 전체의 9%이상이면 Label표시
                    // 카테고리 센터 각도 구하기(label표시 위치)
                    let halfAngle = startAngle + (endAngle - startAngle) * 0.5
                    // the ratio of how far away from the center of the pie chart the text will appear
                    let textPositionValue : CGFloat = 0.65
                    let segmentCenter = CGPoint(x: center.x + radius * textPositionValue * cos(halfAngle), y: center.y + radius * textPositionValue * sin(halfAngle))
                
                    // 카테고리 이름 및 시간 가져오기
                    let name: NSString = segment.segment!.name as NSString
                    let (_,_,minute,hour) = self.divideSecond(timeInterval: segment.value )
                    let timeString: NSString = "\(hour) : \(minute)" as NSString
                
                    //set textRender size 설정
                    var renderRect = CGRect(origin: .zero, size: name.size(withAttributes: self.textAttributes))
                    var renderTimeRect = CGRect(origin: .zero, size: timeString.size(withAttributes: self.textAttributes))
                    
                    //카테고리 색의 RGB평균을 구하여 0.7보다 크면 검은색, 작으면 흰색 글씨로 표시
                    if let RGB = color.cgColor.components {
                        var averageRGB: CGFloat = 0
                        
                        if color.cgColor.numberOfComponents == 2{
                            averageRGB = RGB[0]
                        }else{
                            averageRGB = (RGB[0] + RGB[1] + RGB [2]) / 3
                        }
                        self.textAttributes[NSAttributedString.Key.foregroundColor] = (averageRGB > 0.7) ? UIColor.black : UIColor.white
                    }
                    
                    // center the origin of the rect
                    renderRect.origin = CGPoint(x: segmentCenter.x - renderRect.size.width * 0.5, y: segmentCenter.y - renderRect.size.height * 0.5)
                
                    renderTimeRect.origin = CGPoint(x: segmentCenter.x - renderTimeRect.size.width * 0.5, y: segmentCenter.y - renderRect.size.height * -0.5)
                
                    // text(name,time) draw
                    name.draw(in: renderRect, withAttributes: self.textAttributes)
                    timeString.draw(in: renderTimeRect, withAttributes: self.textAttributes)
                }
                startAngle = endAngle
            }
            
    }
}
