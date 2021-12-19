//
//  GoalTimeTableViewCell.swift
//  StopWatch
//
//  Created by 신상우 on 2021/07/20.
//

import UIKit

class GoalTimeTableViewCell: UITableViewCell {

    lazy var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        self.addSubview(view)
        
        return view
    }()
    
    lazy var goalTitleLabel: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "flag.fill")
        view.tintColor = .darkGray
        
        self.cellView.addSubview(view)
        
        return view
    }()
        
    lazy var goalValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gray
        self.cellView.addSubview(label)
            
        return label
    }()
        
    lazy var goalSubValueLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        self.cellView.addSubview(label)
            
        return label
    }()
    
    lazy var currentTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 20)
        label.textColor = .gray
        label.text = "현 재 : "
//        self.cellView.addSubview(label)
        
        return label
    }()
        
    lazy var currentValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 20)
        label.textColor = .gray
//        self.cellView.addSubview(label)
            
        return label
    }()
        
    lazy var currentSubValueLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        label.textColor = .gray
//        self.cellView.addSubview(label)
            
        return label
    }()
    
    lazy var remainingTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gray
        label.text = "잔 여 : "
//        self.cellView.addSubview(label)
        
        return label
    }()
        
    lazy var remainingTimeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gray
//        self.cellView.addSubview(label)
            
        return label
    }()
    
    lazy var remainingTimeSubValueLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
//        self.cellView.addSubview(label)
            
        return label
    }()
    
    lazy var persentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15, weight: .thin)
        self.addSubview(label)
        
        return label
    }()
        
    //MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
        self.layOut()

    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    //MARK: Method
    func configure(){
        self.backgroundColor = .white
    }
    
    //MARK: LayOut
    func layOut() {
        NSLayoutConstraint.activate([
            self.cellView.topAnchor.constraint(equalTo: self.topAnchor,constant: -6),
            self.cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            self.cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant:  6),
            self.cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
               
            self.goalTitleLabel.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor, constant: 20),
            self.goalTitleLabel.topAnchor.constraint(equalTo: self.cellView.topAnchor, constant: 10),

            self.goalValueLabel.topAnchor.constraint(equalTo: self.cellView.topAnchor, constant: 10),
            self.goalValueLabel.leadingAnchor.constraint(equalTo: self.goalTitleLabel.trailingAnchor, constant: 10),

            self.goalSubValueLabel.leadingAnchor.constraint(equalTo: self.goalValueLabel.trailingAnchor, constant: 5),
            self.goalSubValueLabel.centerYAnchor.constraint(equalTo: self.goalTitleLabel.centerYAnchor, constant: 2),
            
//            self.currentTitleLabel.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor, constant: 20),
//            self.currentTitleLabel.topAnchor.constraint(equalTo: self.goalTitleLabel.bottomAnchor),
//
//            self.currentValueLabel.leadingAnchor.constraint(equalTo: self.currentTitleLabel.trailingAnchor),
//            self.currentValueLabel.topAnchor.constraint(equalTo: self.goalValueLabel.bottomAnchor),
//
//            self.currentSubValueLabel.leadingAnchor.constraint(equalTo: self.currentValueLabel.trailingAnchor, constant: 5),
//            self.currentSubValueLabel.centerYAnchor.constraint(equalTo: self.currentValueLabel.centerYAnchor, constant: 2),
//
//            self.remainingTimeTitleLabel.topAnchor.constraint(equalTo: self.currentTitleLabel.bottomAnchor),
//            self.remainingTimeTitleLabel.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor, constant: 20),
//
//            self.remainingTimeValueLabel.leadingAnchor.constraint(equalTo: self.remainingTimeTitleLabel.trailingAnchor),
//            self.remainingTimeValueLabel.topAnchor.constraint(equalTo: self.currentValueLabel.bottomAnchor),
//
//            self.remainingTimeSubValueLabel.leadingAnchor.constraint(equalTo: self.remainingTimeValueLabel.trailingAnchor, constant: 5),
//            self.remainingTimeSubValueLabel.centerYAnchor.constraint(equalTo: self.remainingTimeValueLabel.centerYAnchor, constant: 2),
            
            self.persentLabel.centerYAnchor.constraint(equalTo: self.cellView.centerYAnchor),
            self.persentLabel.trailingAnchor.constraint(equalTo: self.cellView.trailingAnchor, constant: -20),
            
        ])
    }
}
