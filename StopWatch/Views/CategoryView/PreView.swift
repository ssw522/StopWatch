//
//  preView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/05/06.
//

import UIKit
import RealmSwift

class PreView: UIView {
    //MARK: Porperties
    var total: TimeInterval = 0.0
    lazy var radius = min(self.frame.width, self.frame.height) * 0.45
    let palette = Palette()
    let segment = try! Realm().objects(Segments.self)
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        //label.text = "PreViewChart"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.layOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Metohd
    func configure(){
        self.backgroundColor = .white
    }
    
    //MARK: LayOut
    
    func layOut(){
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
    //MARK: Draw
    override func draw(_ rect: CGRect) {
        self.total = TimeInterval(10 * segment.count)
        
        if total != 0 {
            let center = CGPoint(x: rect.midX, y: rect.midY)
            var endAngle: CGFloat = 0.0
            var startAngle: CGFloat = ((-.pi) / 2)
            
            segment.forEach(){(segment) in
                let ratioTime = CGFloat(10 / self.total)
                endAngle = startAngle + (ratioTime * (.pi * 2))
                let path = UIBezierPath()
                path.move(to: center)
                path.addArc(withCenter: center, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                
                self.palette.paints[segment.colorRow].setFill()
                path.fill()
                // divide line stroke
                UIColor.white.setStroke()
                path.lineWidth = 2
                path.close()
                path.stroke()
                
                startAngle = endAngle
            }
            
        }
    }
}
