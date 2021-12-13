//
//  GoalTimeTotalView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/08/14.
//

import UIKit

class GoalTimeTotalView: UIView {
    //MARK:Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.text = "GoalTime"
        label.textAlignment = .left
        label.textColor = .lightGray
        
        
        return label
    }()
    
    let totalTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 38, weight: .regular)
        label.text  = "00시간 00분"
        label.textAlignment = .left
        label.textColor = .black
        
        
        return label
    }()
    
    let separateLineView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    //MARK:Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.addSubView()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:Configure
    func configure(){
        self.backgroundColor = .standardColor
    }
    
    //MARK:AddSubView
    func addSubView(){
        self.addSubview(self.totalTimeLabel)
        self.addSubview(self.separateLineView)
        self.addSubview(self.titleLabel)
    }
    
    //MARK:Layout
    func layout(){
        NSLayoutConstraint.activate([
            self.titleLabel.bottomAnchor.constraint(equalTo: self.totalTimeLabel.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            self.totalTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.totalTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            self.separateLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.separateLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.separateLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.separateLineView.heightAnchor.constraint(equalToConstant: 2)
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
