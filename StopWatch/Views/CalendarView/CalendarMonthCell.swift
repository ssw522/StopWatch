//
//  CalendarMonthCell.swift
//  StopWatch
//
//  Created by 신상우 on 2022/03/17.
//

import UIKit

class CalendarMonthCell: UICollectionViewCell {
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Chalkboard SE", size: 12)
        label.textColor = .darkGray
        
        return label
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Chalkboard SE", size: 12)
        label.textColor = .darkGray
        label.text = "00:00"
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.backgroundColor = .systemGray6
        
        return label
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        
        self.addSubview(self.dateLabel)
        self.addSubview(self.timeLabel)
        
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - layout
    func layout(){
        NSLayoutConstraint.activate([
            self.dateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            self.timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10)
        ])
    }
}
