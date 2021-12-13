//
//  CustomView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/08/07.
//

import UIKit

class CustomView: UIView {
    //MARK: Properties
    lazy var goalTimeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = customBrownColor.cgColor
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.backgroundColor = .blue
        self.addSubview(view)
        
        return view
    }()
    
    lazy var goalTimeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = customBrownColor
        label.textAlignment = .center
        label.text = "GOAL"
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        self.goalTimeView.addSubview(label)
        
        return label
    }()
    
    lazy var goalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00 H 00 m"
        label.textColor = .black
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        self.goalTimeView.addSubview(label)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(){
        self.backgroundColor = .white
    }
    
    //MARK: Method
    func layout(){
        NSLayoutConstraint.activate([
            self.goalTimeView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.goalTimeView.topAnchor.constraint(equalTo: self.topAnchor),
            self.goalTimeView.widthAnchor.constraint(equalToConstant: 180),
            self.goalTimeView.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        
        NSLayoutConstraint.activate([
            self.goalTimeTitle.topAnchor.constraint(equalTo: self.goalTimeView.topAnchor),
            self.goalTimeTitle.bottomAnchor.constraint(equalTo: self.goalTimeView.bottomAnchor),
            self.goalTimeTitle.leadingAnchor.constraint(equalTo: self.goalTimeView.leadingAnchor),
            self.goalTimeTitle.widthAnchor.constraint(equalToConstant: 70),
            
            self.goalTimeLabel.topAnchor.constraint(equalTo: self.goalTimeView.topAnchor),
            self.goalTimeLabel.bottomAnchor.constraint(equalTo: self.goalTimeView.bottomAnchor),
            self.goalTimeLabel.trailingAnchor.constraint(equalTo: self.goalTimeView.trailingAnchor),
            self.goalTimeLabel.leadingAnchor.constraint(equalTo: self.goalTimeTitle.trailingAnchor,constant: -5)
        ])
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
