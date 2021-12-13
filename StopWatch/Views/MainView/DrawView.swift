//
//  DrawView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/04/11.
//

import UIKit

class DrawView: UIView {
    //MARK: properties
    var saveDate = ""
    var total: TimeInterval = 0.0
    lazy var radius = min(self.frame.width, self.frame.height) * 0.40
    
    private lazy var textAttributes : [NSAttributedString.Key : Any] = {
        return [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
    }()
    
    lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nil"
        label.font = .italicSystemFont(ofSize: 50)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .standardColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = (self.frame.width - 60) / 2
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: self.radius * 2),
            label.heightAnchor.constraint(equalToConstant: self.radius * 2)
        ])
        return label
    }()
    
    func date() -> String{
        let date = DateFormatter()
        date.locale = Locale(identifier: Locale.current.identifier)
        date.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        date.dateFormat = "YYYY. MM. dd"
        
        return date.string(from: Date())
    }
    
    //MARK: Draw
    override func draw(_ rect: CGRect) {
        self.saveDate = date()
        let filter = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)
        let segment = filter!.dailySegment
        self.total = segment.reduce(0){
            (result,segment) in
            return segment.value + result
        }
//        if total != 0 {
            self.notificationLabel.isHidden = true
            
            let center = CGPoint(x: rect.midX, y: rect.midY)
            var endAngle: CGFloat = 0.0
            var startAngle: CGFloat = ((-.pi) / 2)
            
            segment.forEach(){(segment) in
                let colorRow = segment.segment?.colorRow
                let color = Palette().paints[colorRow!]
                
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
                
                if ratioTime > 0.09 {
                    //get half Angle
                    let halfAngle = startAngle + (endAngle - startAngle) * 0.5
                    // the ratio of how far away from the center of the pie chart the text will appear
                    let textPositionValue : CGFloat = 0.65
                    let segmentCenter = CGPoint(x: center.x + radius * textPositionValue * cos(halfAngle), y: center.y + radius * textPositionValue * sin(halfAngle))
                
                    // get segment name ,
                    let name: NSString = segment.segment!.name as NSString
                    let (_,_,minute,hour) = self.divideSecond(timeInterval: segment.value )
                    let timeString: NSString = "\(hour) : \(minute)" as NSString
                
                    //set textRender size
                    var renderRect = CGRect(origin: .zero, size: name.size(withAttributes: self.textAttributes))
                    var renderTimeRect = CGRect(origin: .zero, size: timeString.size(withAttributes: self.textAttributes))
                    
                    if let RGB = Palette().paints[colorRow!].cgColor.components{
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
            
//        }else {
//            self.notificationLabel.isHidden = false
//        }
    }
}
