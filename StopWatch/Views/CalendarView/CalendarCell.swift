//
//  CalendarCell.swift
//  SWCalendar
//
//  Created by 신상우 on 2021/08/30.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    //MARK: ProPerties
    let frameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    let dataCheckView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .darkGray
        view.image = UIImage(systemName: "checkmark")
        
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Chalkboard SE", size: 16)
        
        return label
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubView()
        self.layout()
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:Method
    func addSubView(){
        self.addSubview(self.frameView)
        
        self.frameView.addSubview(self.dataCheckView)
        self.frameView.addSubview(self.dateLabel)
    }
    
    func layout(){
        NSLayoutConstraint.activate([
            self.frameView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant:  1),
            self.frameView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -1),
            self.frameView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
            self.frameView.topAnchor.constraint(equalTo: self.topAnchor, constant: 1)
        ])
        
        NSLayoutConstraint.activate([
            self.dataCheckView.centerXAnchor.constraint(equalTo: self.frameView.centerXAnchor),
            self.dataCheckView.widthAnchor.constraint(equalToConstant: 10),
            self.dataCheckView.heightAnchor.constraint(equalToConstant: 10),
            self.dataCheckView.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            self.dateLabel.centerXAnchor.constraint(equalTo: self.frameView.centerXAnchor),
            self.dateLabel.centerYAnchor.constraint(equalTo: self.frameView.centerYAnchor),
        ])
        
    }
    
}
