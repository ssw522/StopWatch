//
//  GoalTimeView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/12/19.
//

import UIKit

class GoalTimeView: UIView {
    
    let frameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .light)
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    lazy var goalTitleImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "flag.fill")
        view.tintColor = .darkGray
        
        self.addSubview(view)
        
        return view
    }()
        
    lazy var goalValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gray
        self.addSubview(label)
            
        return label
    }()
        
    lazy var goalSubValueLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        self.addSubview(label)
            
        return label
    }()
    
    lazy var timeTitleImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "clock")
        view.tintColor = .darkGray
        
        self.addSubview(view)
        
        return view
    }()
        
    lazy var timeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gray
        self.addSubview(label)
            
        return label
    }()
        
    lazy var timeSubValueLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        self.addSubview(label)
            
        return label
    }()
    
    lazy var persentImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "battery.0")
        view.tintColor = .darkGray
        
        self.addSubview(view)
        
        return view
    }()
        
    lazy var persentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gray
        self.addSubview(label)
            
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.frameView)
        self.addSubview(self.actionButton)
        
        self.frameView.addSubview(self.titleLabel)
        
        self.backgroundColor = .white
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.6
//        self.layer.shadowOffset = .zero
        self.layer.cornerRadius = 4
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            self.frameView.topAnchor.constraint(equalTo: self.topAnchor),
            self.frameView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.frameView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.frameView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.frameView.leadingAnchor, constant: 20),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.frameView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.actionButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.actionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.actionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.goalTitleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.goalTitleImageView.topAnchor.constraint(equalTo: self.frameView.bottomAnchor, constant: 10),

            self.goalValueLabel.topAnchor.constraint(equalTo: self.frameView.bottomAnchor, constant: 10),
            self.goalValueLabel.leadingAnchor.constraint(equalTo: self.goalTitleImageView.trailingAnchor, constant: 10),

            self.goalSubValueLabel.leadingAnchor.constraint(equalTo: self.goalValueLabel.trailingAnchor, constant: 5),
            self.goalSubValueLabel.centerYAnchor.constraint(equalTo: self.goalTitleImageView.centerYAnchor, constant: 2),
        ])
        
        NSLayoutConstraint.activate([
            self.timeTitleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.timeTitleImageView.topAnchor.constraint(equalTo: self.goalTitleImageView.bottomAnchor, constant: 10),
            
            self.timeValueLabel.topAnchor.constraint(equalTo: self.goalTitleImageView.bottomAnchor, constant: 10),
            self.timeValueLabel.leadingAnchor.constraint(equalTo: self.timeTitleImageView.trailingAnchor, constant: 10),
            
            self.timeSubValueLabel.leadingAnchor.constraint(equalTo: self.timeValueLabel.trailingAnchor, constant: 5),
            self.timeSubValueLabel.centerYAnchor.constraint(equalTo: self.timeTitleImageView.centerYAnchor, constant: 2)
        ])
        
        NSLayoutConstraint.activate([
            self.persentImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.persentImageView.topAnchor.constraint(equalTo: self.timeTitleImageView.bottomAnchor, constant: 10),
            
            self.persentLabel.topAnchor.constraint(equalTo: self.timeTitleImageView.bottomAnchor, constant: 6),
            self.persentLabel.leadingAnchor.constraint(equalTo: self.persentImageView.trailingAnchor, constant: 10),
        ])
    }
    
}
